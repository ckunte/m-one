= Storm safety

Jacket resting on its bottom remains exposed to oncoming waves in its pre and partially piled states during installation. In these states, it is susceptible to sliding and overturning from environmental actions. It is deemed storm-safe when secured with sufficient number of piles to withstand installation wave environment.

There is a prevalent practice in the industry where jackets on-bottom are commonly assessed for stability by applying 1-year return period environment. This is because piling in well-understood soils takes days (not weeks or months) to complete. As a result, the probability (p) of encountering a design wave within piling duration is sufficiently low. 

The probability of encountering a design wave during piling is given by:

$ p = 1 - e^(- L / T) $

where, 

- L -- piling duration
- T -- return period of design wave

As @pew illustrates, increase in piling duration increases the chance of encountering a design wave non-linearly. And so the best way to lower _p_ is to design the jacket to withstand wave environment with higher return periods, especially if piling duration to achieve storm safety cannot be reduced.

We experienced this issue first-hand in 2019, as our piling durations were expected to be unconventionally long, and we were able to steer the criteria for design in time towards storm-safety.

#figure(
  image("/img/ep.svg", width: 100%),
  caption: [
    The probability of encountering a design wave during piling
  ],
) <pew>

#pagebreak(weak: true)

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ep.py -- Probability of encountering a design wave during piling
2019 ckunte
"""
import numpy as np
import matplotlib.pyplot as plt


def plot_encounter_probability(L, T, lbl):
    for i, j in zip(L, lbl):
        p = (1 - np.exp(-i / T)) * 100  # in %
        plt.semilogx(T, p, label=j + " piling")
        pass
    plt.xlabel("Return period, T (years)")
    plt.ylabel("Probability of encountering design wave, p (%)")
    plt.legend(loc=0)
    plt.savefig("ep.svg")
    plt.close()
    pass


if __name__ == "__main__":
    lbl = ["10 day", "1 month", "2 month", "3 month", "4 month", "6 month"]
    L = [0.027, 0.083, 0.167, 0.250, 0.333, 0.500] # in years
    T = np.arange(1.0, 50.0, 0.1)
    plot_encounter_probability(L, T, lbl)
    pass
```

$ - * - $