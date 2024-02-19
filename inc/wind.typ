= Wind

The following offers a way to visualize wind profile for a given `Uo` and `t` for a range of heights up to a maximum of `h`.

== Based on ISO 19901-1:2005

#figure(
  image("/img/isowind.svg", width: 100%),
  caption: [Wind as per ISO 19901]
) <iw>

Plot code to generate @iw is as follows.

```python
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
```

== Probability density function

#figure(
  image("/img/pdf.svg", width: 100%),
  caption: [Probability density function]
) <p1>

Plot code to generate @p1 is as follows.

```python
#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
pdf.py: 2016 ckunte
"""
import numpy as np
import matplotlib.pyplot as plt

def main():
    # Weibull distribution: probability distribution function 
    # (for extra-tropical storms)
    ## -- begin inputs --
    ls = [1.0, 1.12] # Mean / nominal speed
    lf = [0.78, 0.94] # Mean / nominal force
    ## -- end inputs ----

    k = 5. # Safety index

    x = np.linspace(0.,2.5)

    for i, j in zip(ls, lf):
        fs = (k / i) * ((x / i)**(k - 1.)) * np.exp(-(x / i)**k)
        plt.plot(
          x, fs, 
          linewidth=2, label='Mean/nominal speed: %0.2f' %i
          )
        ff = (k / j) * ((x / j)**(k - 1.)) * np.exp(-(x / j)**k)
        plt.plot(
          x, ff, 
          linewidth=2, label='Mean/nominal force: %0.2f' %j
          )
    plt.ylabel('Probability density function (pdf) of wind speed')
    plt.xlabel('Normalised wind speed')
    plt.grid(True)
    plt.legend(loc=0)
    plt.savefig('pdf.svg')
    plt.show()
    pass

if __name__ == '__main__':
    main()
```

== Based on EN 1991-1-4:2005

The generic nature of EN's applicability makes for a complicated recipe. The number of things one needs to determine before one even gets to wind velocity is staggering. Here's a flavour of things that come with the territory.

#figure(
  image("/img/enwind.png", width: 100%),
  caption: [PVP, RF, TI, TLS]
) <enw>

Here is the code for these plots.

```python
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
            print("No option was selected. For help, try:\
              python enwind.py -h")
    else:
        print("height >", zt, "m for which these plots are\
          not appropriate.")
    pass
    
if __name__ == '__main__':
    main()
```

$ - * - $
