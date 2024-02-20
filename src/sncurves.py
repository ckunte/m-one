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
    plt.loglog(n, s, base=10, color=graphcolor, linewidth=1.0, label=curve)
    # For slope 2 (m2)
    n = np.arange(r_mid, r_end, 1.0e3)
    s = (n / 10**a2) ** (-1 / m2)
    return plt.loglog(n, s, base=10, color=graphcolor, linewidth=1.0)


def main():
    # Plot all
    style()
    sncurve("TJ curve", 1.0e3, r[0], 1.0e9, a[0], m[0], a[1], m[3], "black")
    sncurve(" B curve", 1.0e3, r[1], 1.0e9, a[2], m[2], a[3], m[3], "magenta")
    sncurve(" C curve", 1.0e3, r[2], 1.0e9, a[4], m[1], a[5], m[3], "blue")
    sncurve(" D curve", 1.0e3, r[3], 1.0e9, a[6], m[0], a[7], m[3], "orange")
    sncurve(" E curve", 1.0e3, r[3], 1.0e9, a[8], m[0], a[9], m[3], "green")
    sncurve(" F curve", 1.0e3, r[3], 1.0e9, a[10], m[0], a[11], m[3], "olive")
    sncurve("F2 curve", 1.0e3, r[3], 1.0e9, a[12], m[0], a[13], m[3], "brown")
    sncurve(" G curve", 1.0e3, r[3], 1.0e9, a[14], m[0], a[15], m[3], "deeppink")
    sncurve("W1 curve", 1.0e3, r[3], 1.0e9, a[16], m[0], a[17], m[3], "olivedrab")
    plt.legend(loc=0)
    plt.xlabel("Number of cycles, N")
    plt.ylabel("Hotspot stress, $\sigma$ (MPa)")
    return plt.savefig("sncurves.svg")


if __name__ == "__main__":
    main()