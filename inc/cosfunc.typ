= Cosine interaction

While reviewing the changes introduced in the new ISO 19902:2020 standard, this one jumped at me:

#quote()[
  tubular member strength formulae for combined axial and bending loading now of cosine interaction form instead of previously adopted linear interaction;  
]

In ISO 19902:2020, the combined unity check for axial (tension | compression) + bending takes the following general expression:

$ U_m = 1 - cos(pi / 2 (gamma_(R,t|c) sigma_(t|c)) / f_(t|y c)) + (gamma_(R,b) sqrt(sigma^2_(b,y)) + sigma^2_(b,z)) / f_b $

This form of unity check has existed since 1993 in API RP-2A LRFD, 1st edition, and whose introduction into ISO 19902:2020 is briefly described in $section$A13.3.2 and $section$A13.3.3. This form makes its presence felt throughout _&sect;13 Strength of tubular members_.#footnote[This form, i.e., 1 - cos(x) occurs in as many as eleven equations, viz., Eq. 13.3-1, 13.3-2, 13.3-4, 13.3-8, 13.3-18, 13.3-19, 13.3-21, 13.3-23, 13.4-7, 13.4-13, and 13.4-19 in ISO 19902:2020. Curiously, this is not applied to dented tubes in §13.7.3, whose combined UC expression(s) remains like before.]

Previously, _Um_ in ISO 19902:2007 was expressed as:

$ U_m = gamma_(R,t|c) sigma_(t|c) / f_(t|y c) + gamma_(R,b) sqrt(sigma^2_(b,y) + sigma^2_(b,z)) / f_b $

The reduction of _Um_ in the first equation is notable, see Figure below. For example, if the axial unity check value (x) is, say, 0.2, then its contribution is reduced to $0.05 (= 1 - cos(pi / 2 x)$. Remember `cos()` is in radians.

#figure(
   image("/img/tuc_under_cosint.svg", width: 100%),
   caption: [
     Axial utilisation versus axial component under cosine interaction in the combined utilisation expression
   ]
) <cf1>

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
cosplay.py -- Effect of cosine interaction form on axial utilisation 
component in the combined axial + bending utilisation expressions
2022 ckunte
"""
import numpy as np
import matplotlib.pyplot as plt


def cosinefunc(uc_t):
    return 1 - np.cos(uc_t * np.pi / 2.0)


def plot_tuc_under_cosinteraction(uc_t):
    cfunc = cosinefunc(uc_t)
    plt.xlabel("$\\frac{\\gamma_{R,t|c}\\,\\sigma_{t|c}}{f_{t|yc}}$")
    plt.ylabel(
        "$1 - \\cos\\left(\\frac{\\pi}{2}\\frac{\\gamma_{R,t|c}\\,\\sigma_{t|c}}{f_{t|yc}}\\right)$"
    )
    plt.plot(uc_t, cfunc)
    plt.savefig("tuc_under_cosint.svg")
    plt.show()


if __name__ == "__main__":
    # Increasing tension utilisation from 0.0 to 1.0
    t1 = np.arange(0.01, 1.0, 0.01)
    plot_tuc_under_cosinteraction(t1)
```

$ - * - $