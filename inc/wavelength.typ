= Wave length

This is a script I have had to write at different times and in different tools in the past --- either to figure out the depth type or when requiring appropriate wave length(s) to calculate hydrostatic pressure. Here's hoping this will be the last.

For background, dispersion relation#footnote[Dispersion relation (eq. 24), Wave and Wave Effects (pp. 240--246), J.N. Newman, Marine Hydrodynamics, The MIT Press, 1977.], which expresses wave length ($lambda$)#footnote[$lambda$ is not to be confused with `lambda` the anonymous function in python programming language.] in terms of wave number ($kappa = 2pi / lambda$) and angular wave frequency ($omega = 2pi / T$) is as follows:

$ omega^2 / g = kappa tanh(kappa d) $

When $lim_(arrow.r oo) tanh(k d) tilde.eq 1$, it reduces the expression to:

$ lambda = 2pi g / omega^2 $

For practical purposes, water depth (d) is considered deep when $d / lambda gt.eq 0.5$. In other words,

$ lambda_d = 2pi g / omega^2 = g T^2 / 2pi $

For shallow water depth (i.e., $d / lambda eq.lt 0.05$), wave length is expressed as:

$ lambda_s = T sqrt(g d) $

This is because $lim_(arrow.r oo) tanh(k d) tilde.eq k d$. For intermediate water depth (i.e., $0.05 < d / lambda < 0.5$), wave length can be expressed as:

$ lambda_i = lambda_d sqrt(tanh( 2pi d / lambda_d)) $

Turning this above into code for a list of wave periods:

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Determine water depth type and corresponding wave length
wavelength.py -- 2020 ckunte
"""
import numpy as np

g = 9.81  # Acceleration due to gravity (m/s^2)


def L_d(d, T):
    return [g * x**2 / (2 * np.pi) for x in T]


def L_s(d, T):
    return [x * np.sqrt(g * d) for x in T]


def L_i(d, T):
    return [x * np.sqrt(np.tanh(2 * np.pi * d / x)) for x in L_d(d, T)]


def typ_check(d, T):
    # Get all wave lengths in to one list
    L_all = [L_d(d, T), L_s(d, T), L_i(d, T)]
    # Water depth to wave length ratio, r
    r = [d / x for sublist in L_all for x in sublist]
    # Depth type check and append `typ_all` list
    typ_all = [
        "Deep" if item >= 0.5 
        else "Shallow" if item <= 0.05 
        else "Intermediate"
        for item in r
    ]
    # Check for majority
    typ = max(typ_all, key=typ_all.count)
    return typ


def wavelength(d, T):
    typ = typ_check(d, T)
    print(f"Water depth type (by majority): {typ}")
    # Print wave lengths
    if typ == "Deep":
        return print(f"Wave length, Ld: {L_d(d, T)}")
    elif typ == "Shallow":
        return print(f"Wave length, Ls: {L_s(d, T)}")
    elif typ == "Intermediate":
        return print(f"Wave length, Li: {L_i(d, T)}")
    else:
        return print(f"d/T ratio does not match a criteria.")


def main(d, T):
    print(f"Water depth: {d}")
    print(f"Wave periods: {T}")
    wavelength(d, T)
    pass


if __name__ == "__main__":
    # -- BEGIN USER INPUTS --
    d = 171.18  # Water depth (m)
    T = [9.4, 11.5, 12.0]  # Wave periods (s)
    # -- END of USER INPUTS --
    main(d, T)
```
When run, it produces this:

```bash
$ python3 wavelength.py
Water depth: 171.18
Wave periods: [9.4, 11.5, 12.0]
Water depth type (by majority): Deep
Wave length, Ld: [137.95735086939, 206.483246406490, 224.828638809335]
```

$ - * - $