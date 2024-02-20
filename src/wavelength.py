#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Determine water depth type and corresponding wave length
wavelength.py -- 2020 ckunte
"""
import numpy as np

g = 9.81  # Acceleration due to gravity (m/s^2)


def L_d(d, T):
    return [g * x**2 / (2 * np.pi) for x in T]


def L_s(d, T):
    return [x * np.sqrt(g * d) for x in T]


def L_i(d, T):
    return [x * np.sqrt(np.tanh(2 * np.pi * d / x)) for x in L_d(d, T)]


def typ_check(d, T):
    # Get all wave lengths in to one list
    L_all = [L_d(d, T), L_s(d, T), L_i(d, T)]
    # Water depth to wave length ratio, r
    r = [d / x for sublist in L_all for x in sublist]
    # Depth type check and append `typ_all` list
    typ_all = [
        "Deep" if item >= 0.5 else "Shallow" if item <= 0.05 
        else "Intermediate"
        for item in r
    ]
    # Check for majority
    typ = max(typ_all, key=typ_all.count)
    return typ


def wavelength(d, T):
    typ = typ_check(d, T)
    print(f"Water depth type (by majority): {typ}")
    # Print wave lengths
    if typ == "Deep":
        return print(f"Wave length, Ld: {L_d(d, T)}")
    elif typ == "Shallow":
        return print(f"Wave length, Ls: {L_s(d, T)}")
    elif typ == "Intermediate":
        return print(f"Wave length, Li: {L_i(d, T)}")
    else:
        return print(f"d/T ratio does not match a criteria.")


def main(d, T):
    print(f"Water depth: {d}")
    print(f"Wave periods: {T}")
    wavelength(d, T)
    pass


if __name__ == "__main__":
    # -- BEGIN USER INPUTS --
    d = 171.18  # Water depth (m)
    T = [9.4, 11.5, 12.0]  # Wave periods (s)
    # -- END of USER INPUTS --
    main(d, T)