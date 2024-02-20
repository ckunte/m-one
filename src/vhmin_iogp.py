#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
# Offshore crane minimum off-board hoisting velocity
# vhmin_iogp.py -- 2016-21 ckunte
# Dec 2018: IOGP fixes the issue w/ API's low vhmin prescription
# Mar 2021: code re-factored

import numpy as np
import matplotlib.pyplot as plt


def api_spec_2c(*args):
    cf = 3.2808  # ft -> m conversion factor
    v_main = (-0.0032 * (x * cf) ** 2 + 0.179 * (x * cf) + 0.0499) / cf
    v_auxi = 1.79 * v_main
    plt.plot(x, v_auxi, color="magenta", label="API spec 2c + IOGP S-618 (Auxi)")
    plt.plot(x, v_main, color="red", label="API spec 2c + IOGP S-618 (Main)")
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
    api_spec_2c(x)
    en_13852_1(x)
    plt.grid(True)
    plt.legend(loc=0)
    plt.title("API v. EN for (off-board) lift off supply vessel")
    plt.xlabel("$H_{sig}$ (m)")
    plt.ylabel("$v_{h\,min}$ (m/s)")
    plt.savefig("vhmin_iogp.svg")
    plt.close()
    pass


if __name__ == "__main__":
    # x: significant wave height ranges
    x = np.arange(0.0, 3.0, 0.001)
    plot_min_hoist_velo(x)
    pass