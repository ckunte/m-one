#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
cosint.py -- Effect of cosine interaction form on axial utilisation 
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
        "$1 - \\cos\\left(\\frac{\\pi}{2}\\frac{\\gamma_{R,t|c}\\,\
        \\sigma_{t|c}}{f_{t|yc}}\\right)$"
    )
    plt.plot(uc_t, cfunc)
    plt.savefig("tuc_under_cosint.svg")
    plt.show()


if __name__ == "__main__":
    # Increasing tension utilisation from 0.0 to 1.0
    t1 = np.arange(0.01, 1.0, 0.01)
    plot_tuc_under_cosinteraction(t1)