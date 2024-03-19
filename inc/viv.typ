= Vortex induced vibration

Effects of vortex shedding can be problematic for slender structural members. Shedding frequencies and their interactions, together with other hydrodynamic quantities (e.g. (a) added mass and damping, (b) Reynolds number, (c) lift coefficient and (d) correlation of force components) have the potential to impair. 

Given that vortex induced vibration (VIV) continues to be an area of contemporary research, the slender elements are commonly engineered to prevent VIV, and where unavoidable, countermeasures (VIV suppression devices e.g. strakes) are introduced.

Following the industry recognised recommended practice, _DNVGL-RP-C205 -- Environmental conditions and environmental loads_, the _viv.py_ script below checks for the occurrence of VIV for a range of user-specified pipe sizes subjected to current(s) in the water column.

#figure(
    table(
      columns: (auto, 1fr),
      inset: 10pt,
      align: horizon,
      [_Excitation_], [_Lock-in_],
      [Inline], [$1.0 lt.eq v_r lt.eq 4.5$, and $K_s lt.eq 1.8$],
      [Crossflow], [$3.0 lt.eq v_r lt.eq 16.0$],
    ),
    caption: [Vortex shedding resonance],
) <vi1>

The script requires the following inputs (together with consistent units). These are to be provided by the user by editing the `viv.py` and updating input parameters marked under _User inputs_ section:

+ Current velocity, v (m/s) --- typically for a 1-year environment
+ Marine growth thickness, tm (m)
+ Flooding condition, f (`1` for flooded; `0` for buoyant)
+ End (boundary) conditions of the pipe (fixed: `22.2`; clamped: `15.4`; simply-supported: `9.87`; cantilevered: `3.52`)

#figure(
  image("/img/vivc.svg", width: 100%),
  caption: [
    Vortex induced vibration check for a range of pipe diameters and span lengths
    ]
) <vi2>

The way to read the above graph is pretty simple:

+ Unshaded area (or area in white background) is the safe area.
+ The intersection of the curve (for each pipe size of D$times$t) with the upper boundary of the non-shaded area (i.e., $V_r$ = 1.0) indicates the max. possible pipe length (span) that is unlikely to experience VIV from (ocean) current. For example, 762OD$times$22WT pipe can span up to 40m, while a 406OD$times$22WT only up to 22m before VIV occurs.
+ The shaded overlap is a zone in which both inline as well as crossflow VIV excitations occur. (See range of occurrences in @vi1.)

Code for generating the plot shown in @vi2 is as follows.

#let viv = read("/src/viv.py")
#{linebreak();raw(viv, lang: "python")}

While the upper limit for cross-flow VIV lock-in is 16 (according to RP-C205), the plot may be set to a lower maximum value of say 5.0 --- e.g. as done in the plot above to keep the curvatures of plots more readable (in `plt.axhspan()` in the script) as so. Change the following line:

```python
plt.axhspan(3.0, 16.0, facecolor='orange', alpha=0.18)
```
to:

```python
plt.axhspan(3.0, 5.0, facecolor='orange', alpha=0.18)
```
One may use the unix command `seq` to generate a range of diameters like so: `seq <initval> <incr> <endval>`. Here is an example:

```bash
$ seq 0.4064 0.0508 0.7620
```
This generates:
```
0.4064
0.4572
0.508
0.5588
0.6096
0.6604
0.7112
0.762
```

$ - * - $