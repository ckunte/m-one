= Dropped pipe

Last week I had an interesting problem to review at work: For a falling body through the water column, I needed to find the impact energy if it hit infrastructure on seabed. I haven't ever done this before, which itself is a question, isn't it? 

I brought this up during a FaceTime call with my daughter at  university. She said she had written a paper in her pre-university IB diploma years entitled, _"Investigating the relationship between the radius of a body and terminal velocity"_, and emailed a copy. She used _honey_ as the medium, and determined the submerged mass of the falling body, honey's viscosity, et al. How cool is that?

Back to the problem, one can find a wide variety of examples online using a spherical object, and you'd wonder why. It's because much of the theory is from [Stoke's Law][s]. For his experiments, George Stokes used a sphere as the falling body. Whereas my falling body was a pipe with open ends, and I had to calculate its drag force. While Stoke's Law itself is not directly applicable, since it uses properties of a sphere, the basic approach by Stokes for calculating the terminal velocity is still valid.

== Impact energy

Impact energy (W) of a falling body through fluid can be expressed as follows:

$ W = 1 / 2 m v^2 $

where, _m_ is the submerged mass of the object, and _v_ is the velocity of the falling object.

== Terminal velocity

From first principles, as the pipe falls through seawater, its gravitational force ($F_g$) is resisted by its drag force ($F_d$). The maximum velocity achievable by a falling object is known as the _terminal velocity_ ($v_t$), at which $F_g$ = $F_d$ and buoyancy.

$ 
F_g = F_d \
m g = F_("dn") + F_("dt") 
$

$F_("dn")$ is drag force for a cross section normal to the direction of motion, which uses the normal coefficient of drag, $C_("dn")$. Whereas $F_("dt")$ is the drag (frictional) force generated due to the surface area that is parallel to the direction of motion, and which uses the tangential coefficient of drag, $C_("dt")$.

$ F_("dn") = 1 / 2 rho C_("dn") A v^2 $

where, $rho$ is the seawater density, and _A_ is the cross sectional area of the pipe.

$ F_("dt") = 1 / 2 rho C_("dt") pi D L v^2 $

where, _D_ and _L_ are pipe diameter and length respectively. Notice that in $F_("dt")$, I have used only the outer surface. If the diameter is sufficiently large, then one could also potentially consider drag from pipe's inner surface. To keep the problem simple, I have chosen to ignore it because flow through pipe may modify its $C_("dt")$ value, since Reynolds number (an indicator of fluid flow) may change (potentially making it a turbulent flow) when considered within the pipe. Also, the $C_("dt")$ value is already so low at 0.008 for the outer surface, that ignoring surface friction inside the pipe is not too inaccurate.

In the above, $F_d$ formulation is for a pipe falling vertically (i.e., with its longitudinal axis parallel to the direction of motion). This is the worst case since any change in the angle of incidence relative to the direction of motion increases drag substantially due to projected surface area times the drag coefficient.

This then becomes:

$ m g = 1 / 2 rho (C_("dn") A + C_("dt") pi D L) v_t^2 $

Finding terminal velocity ($v_t$) from above is straight forward, as below:

$ v_t = sqrt( (m g) / ( 1 / 2 rho (C_("dn") A + C_("dt") pi D L) ) ) $

Once the terminal velocity is known, we can find the time it takes the dropped pipe from surface to reach seabed using the following expression:

$ y(t) = y_0 - (v_t^2 / g) ln cosh( (g t) / v_t) $

where, y$(t)$ is the altitude w.r.t. time, _g_ is the acceleration due to gravity, $y_0$ is the initial altitude, _t_ is time elapsed, and $v_t$ is of course the terminal velocity.

To determine intermediate velocity of a falling object, the following can be used:

$ v(t) = v_t tanh( (g t) / v_t ) $

For a problem I was reviewing, the plots look somewhat like these with code furnished below for generating them.

#figure(
  image("/img/impact.png", width: 100%),
  caption: [
    Time taken by the falling pipe through seawater versus the depth
  ]
) <im>

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Time versus velocity and depth of a dropped pipe through seawater
2020 ckunte
"""

import numpy as np
import matplotlib.pyplot as plt

# Legend:
#   v_t -- terminal velocity (m/s)
#   t -- time (s)
g = 9.81  # acceleration due to gravity (m/s^2)


def tvelo(v_t, t):
    # v_t -- terminal velocity
    # t -- time
    v = v_t * np.tanh(g * t / v_t)
    plt.plot(t, v, linewidth=2)
    plt.xlabel("Time, t (s)")
    plt.ylabel("Velocity, v (m/s)")
    plt.grid(True)
    plt.savefig("t_v.png")
    plt.close()
    pass


def tdepth(y0, v_t, t):
    y = y0 - (v_t ** 2 / g) * np.log(np.cosh(g * t / v_t))
    plt.plot(t, y, linewidth=2)
    plt.xlabel("Time, t (s)")
    plt.ylabel("Depth, d (m)")
    plt.axhline(y=-168.5, color="r", linestyle=":")
    plt.grid(True)
    plt.savefig("t_d.png")
    plt.close()
    pass


def main():
    tvelo(13.654, np.arange(0.1, 10.0, 0.01))
    tdepth(0.0, 13.654, np.arange(0.1, 14.0, 0.01))
    pass


if __name__ == "__main__":
    main()
```

$ - * - $