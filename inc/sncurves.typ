= S-N curves

In order to set a suitable design criteria, I am looking to compare two classes of S-N curves for a fatigue design, viz., E and F2, and I cannot find a handy plot to refer to, and it is frustrating when standards fail to include. So, I channel it to write some code to roll my own:

#figure(
  image("/img/sncurves.svg", width: 100%),
  caption: [
    S-N curves in seawater with cathodic protection based on ISO 19902
  ]
) <snc>

The basic S-N curve equation is as follows, which one may know is from Paris-Erdogan law (fracture mechanics):

#figure(
  image("/img/sncurves-table.png", width: 100%),
  caption: [
    Basic representative S-N curves, ISO 19902
  ]
) <snt>

$ N = k_1 dot S^(-m) $

The standard does describe it in its logarithmic form, which is as follows:

$ log N = log k_1 - m dot log S $

and then it goes on to furnish its two sets of key components that form parts of the equation --- highlighted below. For graphing purposes, the above can also be written as:

$ S = (N / k_1)^(-1 / m) $

For example, and I am writing this for myself since I struggle with logarithms, if

$ log_10 k_1 = 12.18 $

then,

$ k_1 = 10^(12.18) $

Code for plotting hotspot stresses versus number of cycles, see @snc and @snt, is as follows.

```python
#!/usr/bin/env python3
# encoding: utf-8
"""
sncurves.py -- 2016 ckunte
May 7: Initial commit.
Apr 29, 2020: Code simplified
Dec 27, 2020: basex is now base (since matplotlib V3.3)
Feb 17, 2021: A practical stress range is set for structural steel
"""
import numpy as np
import matplotlib.pyplot as plt

# a = log_10(k1)
a = [
    12.18, 16.13,  # TJ
    14.61, 17.01,  # B
    13.23, 16.47,  # C
    11.78, 15.63,  # D
    11.62, 15.37,  # E
    11.40, 15.00,  # F
    11.23, 14.71,  # F2
    11.00, 14.33,  # G
    10.57, 13.62,  # W1
]
m = [3.0, 3.5, 4.0, 5.0]  # Slope
r = [1.8e6, 1.0e5, 4.68e5, 1.0e6]  # Range limit for curves


def style():
    plt.rcParams["grid.linestyle"] = ":"
    plt.rcParams["grid.linewidth"] = 0.5
    plt.grid(True)


def sncurve(curve, r_start, r_mid, r_end, a1, m1, a2, m2, graphcolor):
    # For slope 1 (m1)
    n = np.arange(r_start, r_mid, 1.0e3)
    s = (n / 10**a1) ** (-1 / m1)
    plt.loglog(n, s, base=10, color=graphcolor, linewidth=1.0, 
      label=curve)
    # For slope 2 (m2)
    n = np.arange(r_mid, r_end, 1.0e3)
    s = (n / 10**a2) ** (-1 / m2)
    return plt.loglog(n, s, base=10, color=graphcolor, linewidth=1.0)


def main():
    # Plot all
    style()
    sncurve("TJ curve", 1.0e3, r[0], 1.0e9, a[0], m[0], a[1], m[3],
      "black")
    sncurve(" B curve", 1.0e3, r[1], 1.0e9, a[2], m[2], a[3], m[3],
      "magenta")
    sncurve(" C curve", 1.0e3, r[2], 1.0e9, a[4], m[1], a[5], m[3],
      "blue")
    sncurve(" D curve", 1.0e3, r[3], 1.0e9, a[6], m[0], a[7], m[3],
      "orange")
    sncurve(" E curve", 1.0e3, r[3], 1.0e9, a[8], m[0], a[9], m[3],
      "green")
    sncurve(" F curve", 1.0e3, r[3], 1.0e9, a[10], m[0], a[11], m[3],
      "olive")
    sncurve("F2 curve", 1.0e3, r[3], 1.0e9, a[12], m[0], a[13], m[3],
      "brown")
    sncurve(" G curve", 1.0e3, r[3], 1.0e9, a[14], m[0], a[15], m[3],
      "deeppink")
    sncurve("W1 curve", 1.0e3, r[3], 1.0e9, a[16], m[0], a[17], m[3],
      "olivedrab")
    plt.legend(loc=0)
    plt.xlabel("Number of cycles, N")
    plt.ylabel("Hotspot stress, $\sigma$ (MPa)")
    return plt.savefig("sncurves.svg")


if __name__ == "__main__":
    main()
```

$ - * - $

== Comparison of S-N curves between standards

+ See #link("http://dx.doi.org/10.13140/RG.2.2.14995.20006")[ISO 19902 and DNV-RP-C203]
+ See #link("http://dx.doi.org/10.13140/RG.2.2.28416.97289")[BS 7608 and DNV-RP-C203]

