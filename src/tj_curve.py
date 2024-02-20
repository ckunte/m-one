#!/usr/bin/env python3
# encoding: utf-8
"""
tj_curve.py -- 2016 ckunte
May 7: Initial commit.
Apr 29, 2020: Code simplified
Dec 27, 2020: basex is now base (since matplotlib V3.3)
Feb 17, 2021: A practical stress range is set for structural steel
"""
import numpy as np
import matplotlib.pyplot as plt

# a = log_10(k1)
a = [12.48, 16.13, 12.18, 16.13]  # TJ (air [0-1] and seawater [1-2])
m = [3.0, 5.0]  # Slope
r = [1.0e7, 1.8e6]  # Range limit for curves


def style():
    plt.rcParams["grid.linestyle"] = ":"
    plt.rcParams["grid.linewidth"] = 0.5
    plt.grid(True)


def sncurve(curve, r_start, r_mid, r_end, a1, m1, a2, m2, graphcolor):
    # For slope 1 (m1)
    n = np.arange(r_start, r_mid, 1.0e3)
    s = (n / 10 ** a1) ** (-1 / m1)
    plt.loglog(n, s, base=10, color=graphcolor, linewidth=1.0, 
        label=curve,
    )
    # For slope 2 (m2)
    n = np.arange(r_mid, r_end, 1.0e3)
    s = (n / 10 ** a2) ** (-1 / m2)
    plt.loglog(n, s, base=10, color=graphcolor, linewidth=1.0)
    pass


def main():
    # Plot all
    style()
    sncurve("TJ curve (air)", 
        1.0e3, r[0], 1.0e9, a[0], m[0], a[1], m[1], "blue",
    )
    sncurve(
        "TJ curve (seawater w/ C.P.)", 
        1.0e3, r[1], 1.0e9, a[2], m[0], a[3], m[1], "red",
    )
    plt.legend(loc=0)
    plt.xlabel("Number of cycles, N")
    plt.ylabel("Hotspot stress, $\sigma$ (MPa)")
    plt.savefig("sncurves-tj.svg")
    pass


if __name__ == "__main__":
    main()