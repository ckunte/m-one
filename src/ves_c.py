#!/usr/bin/env python
# encoding: utf-8

"""Influence of cargo eccentricity on sea-transport forces.
Custom vessel based on barge motion responses.
2017 ckunte

Usage: ves_c.py --r=R --p=P --tr=T1 --tp=T2
       ves_c.py -h, --help
       ves_c.py --version

Options:
  -h, --help  Show this help screen.
  --r=R       Single amplitude roll angle in deg [default: 20.0]
  --p=P       Single amplitude pitch angle in deg [default: 12.5]
  --tr=T1     Single amplitude roll period in seconds [default: 10.]
  --tp=T2     Single amplitude pitch period in seconds [default: 10.]
  --version   Show version.

"""
import numpy as np
import matplotlib.pyplot as plt
try:
    from docopt import docopt
except ImportError:
    raise ImportError('Requires docopt: run pip install docopt')

# Acceleration due to gravity
g = 9.81
# Heave amplitude in terms of acceleration due to gravity, g
h = 0.2

args = docopt(__doc__, version='Custom vessel: Infl. of cargo ecc. on inertia forces, version: 0.1')
r = float(args['--r'])
p = float(args['--p'])
Tr = float(args['--tr'])
Tp = float(args['--tp'])

def misc():
    plt.legend(loc=0)
    plt.grid(True)
    plt.xlabel('L (m)')
    plt.ylabel('Inertia force in terms of W')
    plt.show()
    pass

def pgr():
    # Angular accelerations
    thta_r = r * (2 * np.pi / Tr)**2
    thta_p = p * (2 * np.pi / Tp)**2
    # Lx, Ly, or Lz
    x = np.linspace(0, 30) # Lx range from 0 -- 30m
    y = np.linspace(0, 15) # Ly range from 0 -- 15m
    z = np.linspace(0, 30) # Lz range from 0 -- 30m
    # Vertical force per unit mass
    Fvr = np.cos(r) + (y / g) * thta_r + h * np.cos(r)
    Fvp = np.cos(p) + (x / g) * thta_p + h * np.cos(p)
    # Horizontal force per unit mass
    Fhr = np.sin(r) + (z / g) * thta_r + h * np.sin(r)
    Fhp = np.sin(p) + (z / g) * thta_p + h * np.sin(p)
    # Labels
    lbl = [
    "Fv (roll) incl. gravity (L => Ly)",
    "Fv (pitch) incl. gravity (L => Lx)",
    "Fh (roll) (L => Lz)",
    "Fh (pitch) (L => Lz)"
    ]
    # Plot
    plt.plot(y,Fvr,label=lbl[0],linewidth=2)
    plt.plot(x,Fvp,label=lbl[1],linewidth=2)
    plt.plot(z,Fhr,label=lbl[2],linewidth=2)
    plt.plot(z,Fhp,label=lbl[3],linewidth=2)
    pass

def main():
    r = r * np.pi / 180.0 # in rad
    p = p * np.pi / 180.0 # in rad
    plt.title('Custom vessel')
    pgr()
    misc()
    pass

if __name__ == '__main__':
    main()
