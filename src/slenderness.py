#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Determine tube slenderness
slenderness.py -- 2021 ckunte
"""
import numpy as np


# Tube section properties (A, I, r)
def secprop(D, t):
    # Area of cross section
    A = np.round(np.pi * (D - t) * t, 1)
    # Moment of Inertia
    I = np.round((np.pi / 64.0) * (D**4 - (D - 2 * t) ** 4), 1)
    # Radius of gyration
    r = np.round(np.sqrt(I / A), 3)
    return A, I, r


# Representative elastic local buckling strength (fxe)
def rep_elastic_local_buckling_strength(Cx, D, E, t):
    return 2.0 * Cx * E * t / D


# Representative local buckling strength (fyc)
def rep_local_buckling_strength(fy, fxe):
    fyc = np.where(
        (fy / fxe) <= 0.170, fy, (1.047 - 0.274 * fy / fxe) * fy
        )
    return fyc


# Slenderness parameters
def slenderness_param(fyc, fy, D, E, t, K, L, r):
    # D/t
    d_ovr_t = D / t
    # Get tube slenderness results
    klr = K * L / r
    # Column buckling parameter lmbda, see 13.2.3.2, ISO 19902
    lmbda = (klr / np.pi) * np.sqrt(fyc / E)
    # Limiting parameter 1 as per ISO 19902, Sec. 11.4
    p1 = (80.0 / np.pi) * np.sqrt(fyc / E)
    # Limiting parameter 2 as per ISO 19902, Sec. 11.4
    p2 = fy * D / (E * t)
    return d_ovr_t, klr, lmbda, p1, p2


def main():
    # -- BEGIN USER INPUTS --
    # Yield strength of steel (S420) in MPa
    fy = 400.0
    # Modulus of elasticity (Young's modulus) for structural 
    # steel (N/mm^2)
    E = 2.05e5
    # Tube diameters (mm)
    D = np.array([1300.0, 900.0, 1000.0, 1200.0])
    # Tube wall thicknesses (mm)
    t = np.array([50.0, 20.0, 20.0, 30.0])
    # Tube lengths (mm)
    L = np.array([20518.0, 52151.0, 59685.0, 77500.0])
    # Effective length factor (Table 13.5-1, ISO 19902)
    K = 0.7
    # Elastic critical buckling coefficient
    Cx = 0.3  # Recommended value in Sec. 13.2.3.3, ISO 19902
    # -- END of USER INPUTS --
    A, I, r = secprop(D, t)
    fxe = rep_elastic_local_buckling_strength(Cx, D, E, t)
    fyc = rep_local_buckling_strength(fy, fxe)
    sp = slenderness_param(fyc, fy, D, E, t, K, L, r)
    # Labels list
    labels = [
        "D (mm)            ",
        "t (mm)            ",
        "L (mm)            ",
        "A (mm^2)          ",
        "I (mm^4)          ",
        "r (mm)            ",
        "fy (MPa)          ",
        "fxe (MPa)         ",
        "fyc (MPa)         ",
        "D/t               ",
        "KL/r (NTE 80)     ",
        "lambda            ",
        "lambda (NTE)      ",
        "fyD/Et (NTE 0.069)",
    ]
    # Print results
    # -- print non array item(s)
    print(f"fy (MPa)           = {fy}")
    # -- print array(s)
    for i, j in zip(labels, data_res):  # print array items
        j = np.round(j, 3)  # round results to three decimals
        print(i + " =", j.tolist())  # convert arrays to lists


if __name__ == "__main__":
    main()