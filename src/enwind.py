#!/usr/bin/env python
# -*- coding: UTF-8 -*-

"""Wind action plots based on EN 1991-1-4:2005.
2016 ckunte.

Usage: enwind.py ( -i | -l | -p | -r ) [--height=H]
       enwind.py --help
       enwind.py --version

Options:
  -h, --help  Show this help screen.
  -i          Plot turbulent intensity.
  -l          Plot turbulent length scale.
  -p          Plot peak velocity pressure.
  -r          Plot terrain roughness.
  --height=H  Height of structure [default: 140.]
  --version   Show version.

"""
import numpy as np
import matplotlib.pyplot as plt
from docopt import docopt

z0 = [0.003, 0.01, 0.05, 0.3, 1.0]  # m, Roughness length
zmin = [1.0, 1.0, 2.0, 5.0, 10.] # m, reference length scale
zt = 200. # m, reference height, Annex B.1
Lt = 300. # m, reference length scale, Annex B.1
rho = 1.25 # kg/m^3, air density, \S 4.5

args = docopt(__doc__, version='EN wind action plots, version: 0.1')
h = float(args['--height'])

def misc():
    plt.legend(loc=0)
    plt.grid(True)
    plt.ylabel('Height, z (m)')
    pass

def tls():
    # Wind turbulence, Annex B, EN 1991-1-4:2005
    for i, j in zip(z0, zmin):
        alpha = 0.67 + 0.05 * np.log(i)
        z = np.linspace(j, h)
        # turbulent length scale (m)
        Lz = Lt * (z / zt)**alpha
        plt.plot(Lz, z, label='Terrain: %d' %(z0.index(i)),linewidth=2)
    misc()
    plt.xlabel('Turbulent length scale, $L(z)$')
    plt.savefig('tls.svg')
    pass

def tr():
    # Terrain roughness, Clause 4.3.2, EN 1991-1-4:2005
    for i, j in zip(z0, zmin):
        z = np.linspace(j, h)
        kr = 0.19 * (i / z0[2])**0.07
        cr = kr * np.log(z / i)
        plt.plot(cr, z, label='Terrain: %d' %(z0.index(i)),linewidth=2)
    misc()
    plt.xlabel('Roughness factor, $c_r(z) = v_m(z) / v_b$')
    plt.savefig('rf.svg')
    pass

def ti():
    # Turbulence intensity, \S 4.4, EN 1991-1-4:2005
    for i, j in zip(z0, zmin):
        z = np.linspace(j, h)
        # recommended turbulence factor, eq. 4.7
        k1 = 1.0
        # orography factor for below 3deg gradient, \S 4.3.3
        c0 = 1.0
        # turbulence intensity, \S 4.4
        Iv = k1 / (c0 * np.log(z / i))
        plt.plot(Iv, z, label='Terrain: %d' %(z0.index(i)),linewidth=2)
    misc()
    plt.xlabel('Turbulence intensity, $I_v(z)$')
    plt.savefig('ti.svg')
    pass

def pvp():
    # Peak velocity pressure, \S 4.5, EN 1991-1-4:2005
    for i, j in zip(z0, zmin):
        z = np.linspace(j, h)
        kr = 0.19 * (i / z0[2])**0.07
        cr = kr * np.log(z / i)
        # recommended turbulence factor, eq. 4.7
        k1 = 1.0
        # orography factor for below 3deg gradient, \S 4.3.3
        c0 = 1.0
        # turbulence intensity, \S 4.4
        Iv = k1 / (c0 * np.log(z / i))
        # in terms of vb
        qp = (1.0 + 7.0 * Iv) * 0.5 * cr**2
        plt.plot(qp, z, label='Terrain: %d' %(z0.index(i)),linewidth=2)
    misc()
    plt.xlabel('Peak velocity pressure $q_p(z)$ in terms of $v_b$')
    plt.savefig('pvp.svg')
    pass

def main():
    if h <= zt:
        if args['-p']:
            pvp()
        elif args['-l']:
            tls()
        elif args['-r']:
            tr()
        elif args['-i']:
            ti()
        else:
            print("No option was selected. For help, try: python enwind.py -h")
    else:
        print("height >", zt, "m for which these plots are not appropriate.")
    pass

if __name__ == '__main__':
    main()
