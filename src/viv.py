#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Check for vortex-induced vibration occurrence in drill casing 
due to seawater current, based on DNV-RP-C205
viv.py -- 2019-21 ckunte
Jul 19, 2019: Initial commit
Jan 29, 2021: Code re-factored
"""
import numpy as np
import matplotlib.pyplot as plt


def vivc(*args):
    for i in D:
        # Pipe cross sectional area (m^2):
        A = (np.pi / 4.0) * (i ** 2 - (i - 2 * t) ** 2)
        # Pipe cross sectional moment of inertia (m^4):
        I = (np.pi / 64.0) * (i ** 4 - (i - 2 * t) ** 4)
        # Mass of pipe (kg/m):
        Ms = A * ys
        # Added mass (kg/m):
        Ma = cm * rho * np.pi * (i + 2 * tm) ** 2 / 4.0
        # Entrained mass (kg/m):
        Mi = f * rho * (np.pi / 4) * (i - 2 * t) ** 2
        # Marine growth mass (kg/m):
        Mg = np.pi * (i + tm) * tm * ym
        # Total mass (kg/m):
        Mtot = Ms + Ma + Mi + Mg
        # Pipe natural frequency (Roark):
        fn = (0.5 * c / np.pi) * (E * I / (Mtot * l ** 4)) ** 0.5
        # Stability parameter (Ks):
        Ks = 2 * Mtot * (2 * np.pi * beta) / (rho * (i + 2 * tm) ** 2)
        # Reduced velocity:
        vr = v / (fn * i)
        lbl = "%0.0f$\\times$ %0.0f (D/t=%.1f), Ks=%.1f" % (
            (i * 1e3),
            (t * 1e3),
            (i / t),
            Ks,
        )
        plt.plot(l, vr, label=lbl)
        pass
    plt.title("VIV check for %.1fm/s current" % v)
    # In-line VIV occurrence limits ( 1.0 =< Vr =< 4.5 )
    plt.axhspan(1.0, 4.5, facecolor="r", alpha=0.18)
    # Cross flow VIV occurrence limits (3.0 =< Vr =< 16.0 )
    # change upper limit 16.0 to a lower value for plot
    # clarity, if necessary
    plt.axhspan(3.0, 5.0, facecolor="orange", alpha=0.18)
    plt.grid(True)
    plt.legend(loc=0)
    plt.xlabel("Length of pipe, L (m)")
    plt.ylabel("Reduced velocity, $v_r$")
    plt.savefig("vivc.svg")
    plt.close()
    pass


if __name__ == "__main__":
    # -- USER INPUTS --
    # List of pipe diameters
    D = [0.4064, 0.4572, 0.508, 0.5588, 0.6096, 0.6604, 0.762]
    # Pipe wall thickness
    t = 0.022
    # Pipe length: min.length, max.length, increment (m)
    l = np.arange(0.1, 40.0, 0.1)
    # Pipe flooded state: (1 = flooded; 0 = buoyant)
    f = 1
    # End condition, c: 
    #   fixed = 22.2; 
    #   clamped = 15.4;
    #   simply-supported = 9.87; 
    #   cantilevered = 3.52
    c = 15.4
    # Steel modulus of elasticity (N/m^2)
    E = 2.05e11
    # Steel density (kg/m^3)
    ys = 7850.0
    # Seawater density (kg/m^3)
    rho = 1025.0
    # Structural damping ratio for slender steel pipes in water
    beta = 0.05
    # Current velocity (m/s) for 1-year return period
    v = 0.7
    # Marine growth thickness (m)
    tm = 0.0
    # Marine growth density (kg/m^3)
    ym = 575.0
    # -- END of USER INPUTS --
    # Added mass coefficient (hydrodynamic property)
    cm = 1.2 if (tm > 0.0) else 1.6
    # Plot pipe length versus reduced velocity
    vivc(D, t, l, f, c, E, ys, rho, beta, v, tm, ym, cm)
    pass