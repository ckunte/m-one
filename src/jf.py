#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
jf.py -- Jacket flooding characteristics (viz., rate and time-taken)
for a given buoyancy. This can either be considered either (a) as an
engineered flooding through small bore orifices in, say, jacket legs,
or (b) as a case of accidental flooding (e.g., due to pressure loss
from, say, leaks, diaphragm rupture, faulty/damaged seal etc). 
2021 ckunte
"""
import numpy as np
import matplotlib.pyplot as plt

"""
Legend:
  B -- Buoyancy of the jacket (N)
  D -- Diameter of the (thin-walled) orifice (m)
  Ap -- Projected area of the flood-able compartment (m^2)
  Ar -- Area of orifice (= np.pi * D**2 / 4.0)
  mu -- Frictional coefficient
  V -- Volume of the flood-able compartment (m^3)
"""

# Velocity of water ingress
def velo(h, mu):
    return mu * np.sqrt(2.0 * g * h)


# Hydrostatic head
def head(Ap, B):
    return (B / Ap) / (rho * g)


# Rate of water ingress through orifice
def flowrate(v, D):
    Ar = np.pi * np.square(D) / 4.0
    return Ar * v


# Convert D from mm to m
def conv(D):
    return list(map(lambda x: x * 1e-3, D))


# Main function: plot D (orifice dia.) versus Q (flow rate)
def plot_DvQ(D, Q):
    plt.plot(D, Q)
    style()
    plt.xlabel("Hole diameter, D (m)")
    plt.ylabel("Rate of water ingress, Q (m$^3$/s)")
    plt.savefig("DvQ.svg")
    plt.close()
    pass


# Main function: plot D (orifice dia.) versus t (time taken to flood)
def plot_Dvt(D, t, V, vol_lbl):
    for i, j, k in zip(t, vol_lbl, V):
        plt.semilogy(D, i, label=j + " (%.0f$m^3$)" % (k))
        pass
    style()
    plt.legend(loc=0)
    plt.xlabel("Hole diameter, D (m)")
    plt.ylabel("Time taken to flood, t (hour)")
    plt.savefig("Dvt.svg")
    plt.close()
    pass


# Time to flood a volume from the list V (in hours)
def time2flood(V, Q):
    V_arr = np.array(V)
    Q_arr = np.array(Q)
    return (V_arr[:, None] / Q_arr) / 3600.0


def style():
    # plt.legend(loc=0)
    plt.rcParams["grid.linestyle"] = ":"
    plt.rcParams["grid.linewidth"] = 0.5
    plt.grid(True)


if __name__ == "__main__":
    # --- USER INPUTS ---
    # Jacket buoyancy incl. 2 Nos. tanks (N)
    B = 28000e3
    # List of flood-able volumes (m^3)
    V = [170, 190.0, 6000.0, 900.0] 
    # Labels for volume (V) are in the order as below
    vol_lbl = [
        "Pile sleeve",
        "Lower leg compartment", 
        "Buoyancy tank",
        "Outer leg -- full"
        ]
    # Projected jacket area for calc. pressure head (m^2)
    # (framing member projected area excluded conservatively)
    Ap = 5400.0
    # Hole diameter (mm)
    D = np.arange(1.0, 100.0)
    # Acceleration due to gravity (m/s^2)
    g = 9.81
    # Seawater density (kg/m^3)
    rho = 1025.0
    # Assumed, Table 1-9, Handbook of hydraulic resistance
    mu = 0.75
    # --- END of USER INPUTS ---
    D = conv(D)
    h = head(Ap, B)
    v = velo(h, mu)
    Q = flowrate(v, D)
    t = time2flood(V, Q)
    plot_DvQ(D, Q)
    plot_Dvt(D, t, V, vol_lbl)