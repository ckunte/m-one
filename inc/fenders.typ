= Berthing fenders

To avoid downtime in LNG carrier berthing, I was looking to evaluate the adequacy of breasting dolphins, at an age old jetty, see @bd, coupled temporarily with floating pneumatic fenders (FPF), while new air block fenders (ABF) get procured and replaced.

#figure(
  image("/img/bdolphin.jpg", width: 100%),
  caption: [Aerial view of breasting dolphins],
) <bd>

To assess fenders, I was given performance curves, one that of an ABF from the 70s, and the other of an FPF, furnished by its vendor.

I've put the two together in @fsbs to illustrate how similar they look at first glance, while in fact, how different they actually are. Sharp eyes will quickly notice the inconsistent units, unequal ordinates, and interchanged twin-axes. It's obvious that I needed to put all these four curves on to a single graph to avoid optical illusion. 

#figure(
  image("/img/abfpf.jpg", width: 80%),
  caption: [ABF, FBF performance curves],
) <fsbs>

#figure(
  image("/img/cf.png", width: 80%),
  caption: [Fender performances],
) <fc>

With no data except for these plots, I had to digitize, convert to consistent units, and interpolate between data points to generate this following comparison in @fc. Note the effect units have over curve-slopes. By visual inspection of the first image alone, I'd not have picked up the fact that ABFs perform by a factor of 4 over FPFs at their respective maximum deflections, and by a factor of 2 at equivalent deflections. Also that FPFs are demonstrably softer than ABFs. And just for fun, I've also added cell fender type to the mix.

where,

- EVD curves correspond to Energy v. Displacement,
- RVD curves correspond to Reaction v. Displacement

Code for plotting performance curves of air block, floating pneumatic and cell fenders is as follows.

```python
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
```

$ - * - $
