#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
"""Partial action factor and corresponding reserve strength ratio 
as per EP97-5050 -- 2018 ckunte

Usage: rel_pra.py [--typ=L]
       rel_pra.py --help
       rel_pra.py --version

Options:
  -h, --help  Show help screen
  --typ=L     1 for partial action factor, 2 for RSR [default: 1]
  --version   Show version
"""
import numpy as np
import matplotlib.pyplot as plt
from docopt import docopt

args = docopt(
    __doc__, version="yE and corresponding Rm per EP97-5050, ver 0.2"
)
cat = int(args["--typ"])


def main():
    ## -- begin inputs --
    lbl = [
        "Australian NWS",
        "Gulf of Mexico",
        "Northern North Sea",
        "West Africa",
        "Central and Southern North Sea",
    ]
    A = [1.342, 2.13, 11.9, 19.2351, 180.0]
    E0 = [0.2041, 0.187, 0.1411, 0.1322, 0.102]
    VE = 0.07  # Cd, Cm
    VR = 0.05
    ## -- end inputs ----
    V = np.sqrt(VE ** 2 + VR ** 2)
    # RSR range (min., max.)
    x = np.linspace(1.4, 2.4)
    # Partial action factor (gamma_e)
    gamma_e = x / 1.37
    # PLot all regions
    for i, j, k in zip(A, E0, lbl):
        # Probability of failure (Pf)
        pf = i * np.exp(-x / j) * np.exp((V * x) ** 2 / (2.0 * j ** 2))
        # Return period
        rp = 1 / pf
        # Select plot type
        if cat == 1:
            # Plot Partial action factor v. Return period
            plt.plot(rp, gamma_e, linewidth=2, label=k)
            plt.ylabel("Partial action factor, $\gamma_e$")
            plt.ylim(1.02, 1.7)
        if cat == 2:
            # Plot RSR v. Return period
            plt.plot(rp, x, linewidth=2, label=k)
            plt.ylabel("Reserve strength ratio mean, $R_m$")
            plt.ylim(1.4, 2.4)
        pass
    plt.xscale("log")
    # 2,000-y ret.period (=1/1E-4)
    plt.axvline(x=2000, color="g", linestyle=":")
    # 33,333-y ret.period (=1/3E-5)
    plt.axvline(x=33333, color="b", linestyle=":")
    plt.xlabel("Return period (years)")
    plt.legend(loc=0)
    plt.savefig("rel_pra-%d.svg" % (cat))
    pass


if __name__ == "__main__":
    main()