#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Influence of pile length overhang for a set of motions in terms
of inertia forces, bending and shear stresses. 
2020 ckunte

Usage: ptow-ls.py (--fb | --fv) [--tr=T1] [--tp=T2]
       ptow-ls.py --help
       ptow-ls.py --version

Options:
  --help      Show this help screen
  --fb        Plot bending stresses in pile during tow
  --fv        Plot shear stresses in pile during tow
  --tr=T1     Single amplitude roll period (s) [default: 10.]
  --tp=T2     Single amplitude pitch period (s) [default: 10.]
  --version   Show version.

"""
import numpy as np
import matplotlib.pyplot as plt
from docopt import docopt

args = docopt(
    __doc__,
    version="Influence of overhung pile length on stresses from specific motions, v1.0.0",
)
# -- BEGIN USER INPUTS --
# -------------------------------------------------------------------
#            Lp
#     |<-------------->|
#
#     +---+------------+-----------------+--------+----\
#     +---+---------------------------------------+----/
#     +---+------------+-----------------+--------+---\
#     +---+---------------------------------------+----\
#                (aft) +-----------------+-------------/
# ---------------------|-         Large Barge       --/--------------
#                  --- +                              \  ---
#                   -   `-----------------------------/   -
#     .
#     .                    ELEVATION VIEW
#   ><>
# -------------------------------------------------------------------
# COMPUTE INERTIA FORCES PER UNIT WEIGHT
def inertia(r, p):
    # r and p to be in radians
    r = r * (np.pi / 180.0)
    p = p * (np.pi / 180.0)
    # Angular acceleration: roll
    thta_r = r * (2 * np.pi / Tr) ** 2
    # Angular acceleration: pitch
    thta_p = p * (2 * np.pi / Tp) ** 2
    # Vertical force per unit mass
    Fvr = np.cos(r) + (L[1] / g) * thta_r + h * np.cos(r)
    Fvp = np.cos(p) + (L[0] / g) * thta_p + h * np.cos(p)
    # Horizontal force per unit mass
    Fhr = np.sin(r) + (L[2] / g) * thta_r + h * np.sin(r)
    Fhp = np.sin(p) + (L[2] / g) * thta_p + h * np.sin(p)
    # Resultant inertia force: roll
    Fr = np.sqrt(Fvr ** 2 + Fhr ** 2)
    # Resultant inertia force: pitch
    Fp = np.sqrt(Fvp ** 2 + Fhp ** 2)
    # Resultant inertia forces: quartering
    Fq = np.sqrt((0.6 * Fr) ** 2 + (0.6 * Fp) ** 2)
    # Return results
    return Fr, Fvr, Fhr, Fp, Fvp, Fhp, Fq


# COMPUTE BENDING STRESSES
def bending_stress(r, p):
    # Call results of inertia(r, p) function and multiply each value
    # of the tuple by an LRFD factor of 1.485 (= 1.1 * 1.35)
    F = map(lambda x: x * 1.485, inertia(r, p))
    # Call results of pipe_secprop(D, t) function
    s = pipe_secprop(D, t)
    # For pile section overhung behind vessel stern (cantilever moment)
    # Bending stress (MPa) fb = M / Z, where M = (w * l) * l
    fbvr = ((s[2] * F[1]) * Lp ** 2) / s[1]
    fbhr = ((s[2] * F[2]) * Lp ** 2) / s[1]
    fbr = np.sqrt(fbvr ** 2 + fbhr ** 2)
    fbvp = ((s[2] * F[4]) * Lp ** 2) / s[1]
    fbhp = ((s[2] * F[5]) * Lp ** 2) / s[1]
    fbp = np.sqrt(fbvp ** 2 + fbhp ** 2)
    # where, F[1] => Fvr; F[2] => Fhr; F[4] => Fvp; F[5] => Fhp, and
    # where, s[1] => Ze
    return fbr, fbvr, fbhr, fbp, fbvp, fbhp


# COMPUTE SHEAR STRESSES
def shear_stress(r, p):
    F = map(lambda x: x * 1.485, inertia(r, p))
    s = pipe_secprop(D, t)
    # For pile section overhung behind vessel stern
    # Shear stress (MPa) fv = 2V / A, where V = (w * l)
    fvvr = (2.0 * ((s[2] * F[1]) * Lp)) / s[0]
    fvhr = (2.0 * ((s[2] * F[2]) * Lp)) / s[0]
    fvr = np.sqrt(fvvr ** 2 + fvhr ** 2)
    fvvp = (2.0 * ((s[2] * F[4]) * Lp)) / s[0]
    fvhp = (2.0 * ((s[2] * F[5]) * Lp)) / s[0]
    fvp = np.sqrt(fvvp ** 2 + fvhp ** 2)
    # where, s[0] => A
    return fvr, fvvr, fvhr, fvp, fvvp, fvhp


# COMPUTE PIPE SECTION PROPERTIES
def pipe_secprop(D, t):
    # Cross sectional ar, Lpea
    A = np.pi * (D - t) * t
    # Weight of overhung pile per unit length (in MN/m)
    # where 0.077 MN/m^3 => 7,850 kgf/m^3 (steel unit weight)
    w = A * 1.0 * 0.077
    # This is useful when MN/m^2 => MPa
    # Moment of inertia of the cross section
    I = (np.pi / 64.0) * (D ** 4 - (D - 2 * t) ** 4)
    # Polar moment of inertia of the cross section
    Ip = (np.pi / 32.0) * (D ** 4 - (D - 2 * t) ** 4)
    # Elastic section modulus
    Ze = I / (D / 2.0)
    # Plastic section modulus
    Zp = (1 / 6.0) * (D ** 3 - (D - 2 * t) ** 3)
    # Radius of gyration
    r = np.sqrt(I / A)
    return A, Ze, w


# PLOT FUNCTIONS
def misc():
    # plt.xlabel('Motion angle (deg)')
    plt.xlabel("Pile length overhung beyond stern (m)")
    plt.legend(loc=0)
    plt.grid(True)
    pass


# PLOT PILE LENGTH v. BENDING STRESS (ROLL)
def plot_roll_motion_bendingstress(r, p):
    fb = bending_stress(r, p)
    plt.plot(
        Lp,
        fb[0],
        label="$f_{br} = \\sqrt{f_{bvr}^2 + f_{bhr}^2}$",
        linewidth=2,
    )
    plt.plot(Lp, fb[1], label="$f_{bvr}$", linewidth=2)
    plt.plot(Lp, fb[2], label="$f_{bhr}$", linewidth=2)
    plt.ylabel("Bending stress (MPa)")
    misc()
    plt.axhspan(396.0, 500.0, linewidth=0, facecolor="r", alpha=0.18)
    plt.savefig("pp-fb-roll-ls.png")
    plt.close()
    pass


# PLOT PILE LENGTH v. BENDING STRESS (PITCH)
def plot_pitch_motion_bendingstress(r, p):
    fb = bending_stress(r, p)
    plt.plot(
        Lp,
        fb[3],
        label="$f_{bp} = \\sqrt{f_{bvp}^2 + f_{bhp}^2}$",
        linewidth=2,
    )
    plt.plot(Lp, fb[4], label="$f_{bvp}$", linewidth=2)
    plt.plot(Lp, fb[5], label="$f_{bhp}$", linewidth=2)
    plt.ylabel("Bending stress (MPa)")
    misc()
    plt.axhspan(396.0, 700.0, linewidth=0, facecolor="r", alpha=0.18)
    plt.savefig("pp-fb-pitch-ls.png")
    plt.close()
    pass


# PLOT PILE LENGTH v. SHEAR STRESS (ROLL)
def plot_roll_motion_shearstress(r, p):
    fv = shear_stress(r, p)
    plt.plot(
        Lp,
        fv[0],
        label="$f_{vr} = \\sqrt{f_{vvr}^2 + f_{vhr}^2}$",
        linewidth=2,
    )
    plt.plot(Lp, fv[1], label="$f_{vvr}$", linewidth=2)
    plt.plot(Lp, fv[2], label="$f_{vhr}$", linewidth=2)
    plt.ylabel("Shear stress (MPa)")
    misc()
    plt.savefig("pp-fv-roll-ls.png")
    plt.close()
    pass


# PLOT PILE LENGTH v. SHEAR STRESS (PITCH)
def plot_pitch_motion_shearstress(r, p):
    fv = shear_stress(r, p)
    plt.plot(
        Lp,
        fv[3],
        label="$f_{vp} = \\sqrt{f_{vvp}^2 + f_{vhp}^2}$",
        linewidth=2,
    )
    plt.plot(Lp, fv[4], label="$f_{vvp}$", linewidth=2)
    plt.plot(Lp, fv[5], label="$f_{vhp}$", linewidth=2)
    plt.ylabel("Shear stress (MPa)")
    misc()
    plt.savefig("pp-fv-pitch-ls.png")
    plt.close()
    pass


def main():
    # -- BEGIN USER INPUTS --
    g = 9.81  # Acceleration due to gravity (m/s^2)
    """
    Cargo location w.r.t vessel:
    Lever arm (x, y, z) between vessel C.O.R to overhung pile C.O.G (m):
    """
    L = [np.linspace(0, 20.0), 20.0, 15.25]  # Check for Lx sensitivity
    Lp = L[0] * 2  # length of pile overhung
    L[0] = L[0] + 80  # lx length from vessel COR to stern (= LOA / 2)
    # Steel pile properties:
    D = 3.000  # Pile diameter (m)
    t = 0.038  # Pile wall thickness (m)
    # Motion characteristics:
    r = 20.0  # 20 deg (large barge as per ISO 19901-6:2009)
    Tr = float(args["--tr"])  # Full cycle period: roll (default: 10s)
    p = 10.0  # 10 deg ( -- do --)
    Tp = float(args["--tp"])  # Full cycle period: pitch (default: 10s)
    h = 0.20  # Heave amplitude (h) in terms of g
    # -- END USER INPUTS --
    if args["--fb"]:
        plot_roll_motion_bendingstress(r, p)
        plot_pitch_motion_bendingstress(r, p)
    elif args["--fv"]:
        plot_roll_motion_shearstress(r, p)
        plot_pitch_motion_shearstress(r, p)
    else:
        print(
            "Please select plot option. Try: python ptow-ls.py --help"
        )
    pass


if __name__ == "__main__":
    main()