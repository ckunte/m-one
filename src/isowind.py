#!/usr/bin/env python
# -*- coding: UTF-8 -*-

"""Wind speed plots based on ISO 19901-1:2005.
2016 ckunte.

Usage: isowind.py --speed=S [--height=H]
       isowind.py --help
       isowind.py --version

Options:
  -h, --help  Show this help.
  --speed=S   1h mean wind speed at zr ref. height (m/s).
  --height=H  Maximum height (m). [default: 140.0]

"""
import numpy as np
import matplotlib.pyplot as plt
from docopt import docopt

def main():
    args = docopt(
        __doc__, 
        version='ISO 19901-1 wind speed plots, version: 0.1'
        )
    Uo = float(args['--speed']) # m/s 1h mean wind speed at zr
    h = float(args['--height']) # m, max. height (e.g., a flare tower)

    t = [3., 5., 60., 600., 3600.] # in seconds
    t0 = 3600.0 # s (=> 1h)

    zr = 10.0 # m, ref. height
    z = np.linspace(0.1, h)

    Iuz = 0.06 * (1 + 0.043 * Uo) * (z / zr)**(-0.22)
    C = 0.0573 * (1 + 0.15 * Uo)**(0.5) # for zr = 10m
    Uz = Uo * (1 + C * np.log(z / zr))

    for i in t:
        u = Uz * (1 - 0.41 * Iuz * np.log(i / t0))
        lbl = 'u(z,t) -- %0.0fs' %i
        plt.plot(u, z, label=lbl, linewidth=2)

    # ref: https://goo.gl/CJgoyu
    plt.title(
        'ISO Wind profile (Uo=%.1fm/s at %.1fm reference elevation)' 
        %(Uo,zr)
        )
    plt.ylabel('Height, z (m)')
    plt.xlabel('Wind speed (m/s)')
    plt.legend(loc=0)
    plt.grid(True)
    plt.savefig('isowind.svg')
    pass

if __name__ == '__main__':
    main()
