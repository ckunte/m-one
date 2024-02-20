#!/usr/bin/env python3
# encoding: utf-8
"""
pcurves.py: Plotting performance curves for the following 
fenders:

1. ABF-P 2800X2800 fender, P0 = 1.2kgf/cm^2
2. FPF: Yokohama 2500X4000 - P50 (50kPa)
3. Cell fender MCS 2500, G0

Air block fender (ABF) curves from jetty's as-built 
documentation. Floating pneumatic fender (FPF) curves 
are furnished by Yokohama.

2016 ckunte
"""
import matplotlib.pyplot as plt
import numpy as np
from scipy import interpolate

rcurves = ["ABFRVD", "FPFRVD", "CELRVD"]
ecurves = ["ABFEVD", "FPFEVD", "CELEVD"]

rplot_styles = {"ABFRVD": "m-", "FPFRVD": "b:", "CELRVD": "c--"}
eplot_styles = {"ABFEVD": "g-", "FPFEVD": "r:", "CELEVD": "y--"}

fig, ax1 = plt.subplots()

rdata = {}
for name in rcurves:
    rdata = np.loadtxt("{}.csv".format(name), delimiter=",")
    x = rdata[:, 0]
    y = rdata[:, 1]
    y = y / 1e3  # Converting kN values into MN
    spline = interpolate.splrep(x, y)
    xnew = np.linspace(0, max(x), 100)
    ynew = interpolate.splev(xnew, spline, der=0)
    ax1.plot(xnew, ynew, rplot_styles[name], linewidth=2)

ax2 = ax1.twinx()

edata = {}
for name in ecurves:
    edata = np.loadtxt("{}.csv".format(name), delimiter=",")
    x = edata[:, 0]
    y = edata[:, 1]
    y = y / 1e3  # Converting kN.m in to MN.m
    spline = interpolate.splrep(x, y)
    xnew = np.linspace(0, max(x), 100)
    ynew = interpolate.splev(xnew, spline, der=0)
    ax2.plot(xnew, ynew, eplot_styles[name], linewidth=2)

x_range = 70  # Deflection
y_range = 5.5  # Reaction force or Energy absorption

ax1.legend(rcurves, loc=(0.03, 0.68), frameon=False)
ax2.legend(ecurves, loc=(0.03, 0.83), frameon=False)

ax1.set_xlim((0, x_range))
ax1.set_ylim((0, y_range))
ax2.set_ylim((0, y_range))
ax1.grid()
ax1.set_xlabel("Deflection, D (%)")
ax1.set_ylabel("Reaction force, R (MN)")
ax2.set_ylabel("Energy absorption, E (MJ)")
plt.savefig("fpc-w-cf.svg")
