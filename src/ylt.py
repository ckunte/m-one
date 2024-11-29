#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Plate size check using yield line theory
2024 ckunte
"""
import numpy as np
import matplotlib.pyplot as plt

def plate_fixed_ends(*args):
    for x in Fy:
        Pu = ((x * t**2) / (e * b)) * (2 * b**2 + 2 * e**2 + c * b + L * e) / 1e3
        plt.plot(t, Pu, label="Fy = %i MPa" % (x))
    plt.xlabel("t (mm)")
    plt.ylabel("Pu (kN)")
    plt.title("%s \n (b: %0.fmm, c: %0.fmm, e: %0.fmm, L: %0.fmm)" %(etyp[0], b, c, e, L))
    plt.legend(loc=0)        
    plt.savefig('Pvt_fixed_ends.svg')
    plt.close()


def plate_supported_ends(*args):
    for x in Fy:
        Pu = ((x * t**2) / (e * b)) * (2 * b**2 + e**2 + c * b + L * e / 2) / 1e3
        plt.plot(t, Pu, label="Fy = %i MPa" % (x))
    plt.xlabel("t (mm)")
    plt.ylabel("Pu (kN)")
    plt.title("%s \n (b: %0.fmm, c: %0.fmm, e: %0.fmm, L: %0.fmm)" %(etyp[1], b, c, e, L))
    plt.legend(loc=0)        
    plt.savefig('Pvt_supported_ends.svg')
    plt.close()


if __name__ == '__main__':
    # -- INPUTS:BEGIN --
    # Web plate size range: e.g. 4mm-20mm in 0.1mm increments
    t = np.arange(4.0, 20.0, 0.1)
    # Web plate dimensions
    b = 64.0 # in mm
    c = 0.0 # in mm
    e = 64.0 # in mm
    L = 110.0 # in mm
    # Plate edge type
    etyp = [
        "Min.web plate size for fixed edges (yield line theory)",
        "Min.web plate size for supported edges (yield line theory)"
    ]
    # Yield strength of steel in MPa
    Fy = [240.0, 275.0, 320.0, 345.0, 355.0]
    # -- INPUTS:END --
    # Plot Pu versus t for plate with fixed ends
    plate_fixed_ends(etyp, t, b, c, e, L, Fy)
    # Plot Pu versus t for plate with supported (not fixed) ends
    plate_supported_ends(etyp, t, b, c, e, L, Fy)