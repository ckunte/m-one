#!/usr/bin/env python
# encoding: utf-8

"""Influence of cargo eccentricity on sea-transport forces.
Vessel types are based on Noble Denton Rules and Guidelines 0030/ND.
2017 ckunte

Usage: ves.py ( -l | -m | -s | -v) [--tr=T1] [--tp=T2]
       ves.py -h, --help
       ves.py --version

Options:
  -h, --help  Show this help screen.
  --tr=T1     Single amplitude roll period in seconds [default: 10.]
  --tp=T2     Single amplitude pitch period in seconds [default: 10.]
  -l          Plot for large vessels >140m, >30m
  -m          Plot for medium vessels & large cargo barges >=76m, >=23m
  -s          Plot for small cargo barges <76m, <23m
  -v          Plot for small vessels <76m, <23m
  --version   Show version.

"""
import numpy as np
import matplotlib.pyplot as plt
from docopt import docopt

# Acceleration due to gravity
g = 9.81
# Heave amplitude in terms of acceleration due to gravity, g
h = 0.2

args = docopt(__doc__, version='Influence of cargo eccentricity on sea-transport forces, version: 0.1')
Tr = float(args['--tr'])
Tp = float(args['--tp'])

r = [20.0, 25.0, 30.0] # In degrees
p = [10.0, 12.5, 15.0] # In degrees

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
    if args['-l']:
        r = r[0] * np.pi / 180.0 # in rad => 20 deg
        p = p[0] * np.pi / 180.0 # in rad => 10 deg
        plt.title('Large vessels (LOA > 140m, B > 30m)')
        pgr()
        misc()
    elif args['-m']:
        r = r[0] * np.pi / 180.0 # in rad => 20 deg
        p = p[1] * np.pi / 180.0 # in rad => 12.5 deg
        plt.title('Medium vessels & large cargo barges ($\geq$76m, $\geq$23m)')
        pgr()
        misc()
    elif args['-s']:
        r = r[1] * np.pi / 180.0 # in rad => 25 deg
        p = p[2] * np.pi / 180.0 # in rad => 15 deg
        plt.title('Small cargo barges (<76m, <23m)')
        pgr()
        misc()
    elif args['-v']:
        r = r[2] * np.pi / 180.0 # in rad => 30 deg
        p = p[2] * np.pi / 180.0 # in rad => 15 deg
        plt.title('Small vessels (<76m, <23m)')
        pgr()
        misc()
    else:
        print "No option was selected. For help, try: python ves.py -h"
    pass

if __name__ == '__main__':
    main()
