= Wave length

This is a script I have had to write at different times and in different tools in the past --- either to figure out the depth type or when requiring appropriate wave length(s) to calculate hydrostatic pressure. Here's hoping this will be the last.

For background, dispersion relation#footnote[Dispersion relation (eq. 24), Wave and Wave Effects (pp. 240--246), J.N. Newman, Marine Hydrodynamics, The MIT Press, 1977.@newman_1977], which expresses wave length ($lambda$)#footnote[$lambda$ is not to be confused with _lambda_ the anonymous function in python programming language.@lutz_2013] in terms of wave number ($kappa = 2pi / lambda$) and angular wave frequency ($omega = 2pi / T$) is as follows:

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

#let wavelength = read("/src/wavelength.py")
#{linebreak();raw(wavelength, lang: "python")}
#v(1em)

When run, it produces this:

#v(1em)
```bash
$ python3 wavelength.py
Water depth: 171.18
Wave periods: [9.4, 11.5, 12.0]
Water depth type (by majority): Deep
Wave length, Ld: [137.95735086939, 206.483246406490, 224.828638809335]
```