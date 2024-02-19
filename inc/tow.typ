= Tow

When asked to compare the severity of sea-transportation between the North Sea#footnote[GL Noble Denton, Technical Policy Board --- Table 7-2 (Unrestricted, Case 2), Default Motion Criteria, _Guidelines for Marine Transportations_, Document No. 0030/ND.] and the South China Sea, most engineers side with the former, which they deduce from comparing sea-states. So, it's rare to not get a blank stare from people when I say they may not be right. Here's why. Let us take a look at practised barge motion design criteria in each, see @mot.

At first look, with all motion parameters greater, this may still look like the North Sea is governing over the South China Sea. But is it really? To be sure, let us convert these into accelerations and resulting inertial forces.

#figure(
    table(
      columns: (1fr, auto, auto),
      inset: 10pt,
      align: horizon,
      [], [*North Sea*], [*South China Sea*],
      [Barge size (m)], [>76 $times$ >23], [91.4 $times$ 27.4],
      [Roll ($alpha$, $T_r$)], [20$degree$, 10s], [12.5$degree$, 5s],
      [Pitch ($beta$, $T_p$)], [12.5$degree$, 10s], [8$degree$, 5.5s],
      [Heave (gh)], [0.2g], [0.2g],
    ),
    caption: [Barge motion criteria for medium sized barges],
) <mot>

where, $alpha$ and $beta$ are roll and pitch single amplitude of angular accelerations respectively (in degrees), together with corresponding full cycle periods (in seconds); and _h_ is heave single amplitude of linear acceleration (either in terms of _g_, or in meters).

Maximum acceleration, in a simple harmonic motion without phase info., may be computed as follows:

$ theta_r = omega^2 dot a $

From the above, roll acceleration takes the form:

$ theta_r = ((2pi) / T_r)^2 dot alpha $

Similarly, pitch acceleration takes the form:

$ theta_p = ((2pi) / T_p)^2 dot beta $

where, $T_r$, $T_p$, and $T_h$ are full cycle periods associated with roll, pitch and heave respectively (in seconds).

#figure(
  table(
    columns: (1fr, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [], [*North Sea*], [*South China Sea*], [*Incr*],
    [$theta_r$ $("rad")/s^2$], [0.14], [0.34], [143%],
    [$theta_p$ $("rad")/s^2$], [0.09], [0.22], [144%],
    [gh $m/s^2$], [1.96], [1.96], [--],
  ),
  caption: [Accelerations],
) <acc>

What? How? Well, it is due to the full cycle period associated with motions, the proverbial elephant in the room, because most people read or regard full cycle periods as some sort of meta information. In the case of the South China Sea, however, nonlinearly lower full cycle periods in the denominator drive accelerations up. In turn, inertial forces increase as a consequence of higher accelerations.#footnote[Newton's second law of motion.]

Full cycle (motion) periods are given by:

$ T_r = 2pi sqrt( (r_x^2 + m_a_r) / (#overline[GM]_T dot g) ) $

$ T_p = 2pi sqrt( (r_y^2 + m_a_p) / (#overline[GM]_L dot g) ) $

$ T_h = 2pi sqrt( (m + m_a_h) / (A_w rho g) ) $

These could sometimes be simplified to:

$ T_r = 2pi r_x / sqrt(#overline[GM] dot g) $

$ T_p = 2pi r_y / sqrt(#overline[GM] dot g) $

where,

- $r_x$, $r_y$: radii of gyration along head and beam directions respectively
- $G M_T$, $G M_L$: metacentric height in transverse and longitudinal directions respectively
- $m_a_r$, $m_a_p$, $m_a_h$: added masses for roll, pitch, and heave respectively

There is a reason full (motion) periods are engineered for manned vessels, which is to make motions humanely tolerable as the graph in @hrvm shows.#footnote[Journee and Pinkster, _Introduction to Ship Hydromechanics_.]

#figure(
  image("/img/tow_hra.png", width: 80%),
  caption: [Human response to vessel motions],
) <hrvm>

The boundary of depression and intolerable ranges can occur for very low accelerations, if periods are too low. Whereas a combination of acceleration and its corresponding average frequency of oscillation determines the level of comfort aboard.

However, marine cargo transports often involve unmanned dummy barges, for which human response is not seen as a governing requirement, and are therefore OK to operate at lower periods of motion. High dynamic acceleration is often a result of small period of motion, as seen in the case of South China Sea pertaining to unmanned cargo barges.

One way to manage this is by optimising (static) metacentric height, GM, by keeping it sufficiently high from greater initial stability considerations --- but not excessively high, to warrant low periods of motion. This would not only reduce dynamic accelerations, but also help improve human response, where essential.

== Effect of cargo position on inertia forces

While working on a project recently, I took the opportunity to develop the effect of cargo position on sea-transport forces in unrestricted open-seas (in terms of _W_, which is the dry weight of cargo), and extend it to profile all vessel types described in 0030/ND.

#figure(
  image("/img/tow_lvessels.png", width: 90%),
  caption: [Large vessels],
) <lv>

#figure(
  image("/img/tow_mvessels.png", width: 90%),
  caption: [Medium vessels and large cargo barges],
) <mv>

#figure(
  image("/img/tow_sbarges.png", width: 90%),
  caption: [Small barges],
) <sb>

#figure(
  image("/img/tow_svessels.png", width: 90%),
  caption: [Small vessels],
) <sv>

where, $L_x$, $L_y$, and $L_z$ are are distances between barge centre of rotation and cargo centre of gravity in x (along barge length), y (along barge width), and z (vertical) respectively.

The plot code for all standard vessel types, described in 0030/ND is as follows.

```python
#!/usr/bin/env python
# encoding: utf-8

"""Influence of cargo eccentricity on sea-transport forces. Vessel types
are based on Noble Denton Rules and Guidelines. 0030/ND. 2017 ckunte

Usage: ves.py ( -l | -m | -s | -v) [--tr=T1] [--tp=T2]
       ves.py -h, --help
       ves.py --version

Options:
  -h, --help Show this help screen
  --tr=T1    Single amplitude roll period (s) [default: 10.]
  --tp=T2    Single amplitude pitch period (s) [default: 10.]
  -l         Plot for large vessels >140m, >30m
  -m         Plot for medium vessels >=76m, >=23m
  -s         Plot for small cargo barges <76m, <23m
  -v         Plot for small vessels <76m, <23m
  --version  Show version

"""
import numpy as np
import matplotlib.pyplot as plt
from docopt import docopt

# Acceleration due to gravity
g = 9.81
# Heave amplitude in terms of g
h = 0.2

args = docopt(__doc__, 
    version='Influence of cargo ecc. on sea-transport forces, ver: 0.1')
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
    plt.plot(y, Fvr, label=lbl[0], linewidth=2)
    plt.plot(x, Fvp, label=lbl[1], linewidth=2)
    plt.plot(z, Fhr, label=lbl[2], linewidth=2)
    plt.plot(z, Fhp, label=lbl[3], linewidth=2)
    pass

def main():
    desc = [
    "Large vessels (LOA > 140m, B > 30m)",
    "Medium vessels & large barges ($\geq$76m, $\geq$23m)",
    "Small cargo barges (<76m, <23m)",
    "Small vessels (<76m, <23m)"
    ]
    if args['-l']:
        r = r[0] * np.pi / 180.0 # in rad => 20 deg
        p = p[0] * np.pi / 180.0 # in rad => 10 deg
        plt.title(desc[0])
        pgr()
        misc()
    elif args['-m']:
        r = r[0] * np.pi / 180.0 # in rad => 20 deg
        p = p[1] * np.pi / 180.0 # in rad => 12.5 deg
        plt.title(desc[1])
        pgr()
        misc()
    elif args['-s']:
        r = r[1] * np.pi / 180.0 # in rad => 25 deg
        p = p[2] * np.pi / 180.0 # in rad => 15 deg
        plt.title(desc[2])
        pgr()
        misc()
    elif args['-v']:
        r = r[2] * np.pi / 180.0 # in rad => 30 deg
        p = p[2] * np.pi / 180.0 # in rad => 15 deg
        plt.title(desc[3])
        pgr()
        misc()
    else:
        print "No option was selected. For help, try: python ves.py -h"
    pass

if __name__ == '__main__':
    main()
```

#pagebreak()

For non-standard motion responses, particularly in benign environments that exhibit lower single amplitude motion and lower full cycle period, the following code could be used. It requires all values to be input.

```python
#!/usr/bin/env python
# encoding: utf-8

"""Influence of cargo eccentricity on sea-transport forces. Custom vessel
based on barge motion responses. 2017 ckunte

Usage: ves.py --r=R --p=P --tr=T1 --tp=T2
       ves.py -h, --help
       ves.py --version

Options:
  -h, --help  Show this help screen
  --r=R       Single amp.roll angle (deg) [default: 20.0]
  --p=P       Single amp.pitch angle (deg) [default: 12.5]
  --tr=T1     Single amp.roll period (s) [default: 10.0]
  --tp=T2     Single amp.pitch period (s) [default: 10.0]
  --version   Show version

"""
import numpy as np
import matplotlib.pyplot as plt
try:
    from docopt import docopt
except ImportError:
    raise ImportError(
        'Requires docopt: run pip install docopt'
        )

# Acceleration due to gravity
g = 9.81
# Heave amplitude in terms of g
h = 0.2

args = docopt(
    __doc__, 
    version='Custom vessel: Infl. of cargo ecc. on inertia forces,\
    ver: 0.1'
    )
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
    plt.plot(y, Fvr, label=lbl[0], linewidth=2)
    plt.plot(x, Fvp, label=lbl[1], linewidth=2)
    plt.plot(z, Fhr, label=lbl[2], linewidth=2)
    plt.plot(z, Fhp, label=lbl[3], linewidth=2)
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
```

$ - * - $
