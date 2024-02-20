#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
# Offshore crane minimum off-board hoisting velocity
# vhmin.py -- 2016-21 ckunte
# Mar 2021: code re-factored

import numpy as np
import matplotlib.pyplot as plt


def api_spec_2c(*args):
    cf = 0.3048  # ft -> m conversion factor
    v1 = (0.033 * cf) + 0.098 * x1
    v2 = 0.067 * (x2 + (3.3 * cf))
    plt.plot(x1, v1, color="red", label="API spec 2c")
    plt.plot(x2, v2, color="red")
    pass


def en_13852_1(*args):
    K_H = [0.50, 0.28]  # at rated capacity: [single, multiple] fall reeving
    Vd = 6.0 * x / (x + 8.0)  # crane on fixed platform lifting off supply vessel
    Vc = 0  # crane boom tip velocity
    VH_sfr = K_H[0] * (Vd ** 2 + Vc ** 2) ** 0.5
    VH_mfr = K_H[1] * (Vd ** 2 + Vc ** 2) ** 0.5
    plt.plot(x, VH_sfr, label="EN 13852-1 (RC, SFR)")
    plt.plot(x, VH_mfr, label="EN 13852-1 (RC, MFR)")
    pass


def plot_min_hoist_velo(*args):
    api_spec_2c(x1, x2)
    en_13852_1(x)
    plt.grid(True)
    plt.legend(loc=0)
    plt.title("API v. EN for (off-board) lift off supply vessel")
    plt.xlabel("$H_{sig}$ (m)")
    plt.ylabel("$v_{h\,min}$ (m/s)")
    plt.savefig("vhmin.svg")
    plt.close()
    pass


if __name__ == "__main__":
    # x, x1, x2: significant wave height ranges
    x1 = np.arange(0.0, 1.83, 0.001)
    x2 = np.arange(1.83, 3.0, 0.001)
    x = np.arange(0.0, 3.0, 0.001)
    plot_min_hoist_velo(x1, x2, x)
