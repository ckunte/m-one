= Tow

When asked to compare the severity of sea-transportation between the _North Sea#footnote[GL Noble Denton, Technical Policy Board --- Table 7-2 (Unrestricted, Case 2), Default Motion Criteria, _Guidelines for Marine Transportations_, Document No. 0030/ND.]_ and the _South China Sea_, most engineers side with the former, which they deduce from comparing sea-states. So, it is rare to not get a blank stare from people when I say they may not be right. Here is why. Let us take a look at practised barge motion design criteria in each, see @mot. 

#figure(
    table(
      columns: (auto, 1fr, 1fr),
      inset: 10pt,
      align: horizon,
      [], [_North Sea_], [_South China Sea_],
      [Barge size], [>76m $times$ >23m], [91.4m $times$ 27.4m],
      [Roll ($alpha$, $T_r$)], [20$degree$, 10s], [12.5$degree$, 5s],
      [Pitch ($beta$, $T_p$)], [12.5$degree$, 10s], [8$degree$, 5.5s],
      [Heave (gh)], [0.2g], [0.2g],
    ),
    caption: [Barge motion criteria for medium sized barges],
) <mot>

where, $alpha$ and $beta$ are roll and pitch single amplitude of angular accelerations respectively (in degrees), together with corresponding full-cycle periods (in seconds); and _h_ is heave single amplitude of linear acceleration (either in terms of _g_, or in metres).

With all motion parameters greater, at a glance _North Sea_ appears to govern over the _South China Sea_. But is it really? Let us convert these into accelerations and inertial forces to be sure. Maximum acceleration, in a simple harmonic motion without phase information, may be computed as follows:

$ theta_r = omega^2 dot a $

From the above, roll acceleration takes the form:

$ theta_r = ((2pi) / T_r)^2 dot alpha $

Similarly, pitch acceleration takes the form:

$ theta_p = ((2pi) / T_p)^2 dot beta $

where, $T_r$, $T_p$, and $T_h$ are full-cycle periods associated with roll, pitch, and heave respectively (in seconds).

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    inset: 10pt,
    align: horizon,
    [], [_North Sea_], [_South China Sea_], [_Increase_],
    [$theta_r$ $("rad")/s^2$], [0.14], [0.34], [143%],
    [$theta_p$ $("rad")/s^2$], [0.09], [0.22], [144%],
    [gh $m/s^2$], [1.96], [1.96], [--],
  ),
  caption: [Accelerations],
) <acc>

What? How? 

Well, it is attributable to the full-cycle period associated with motions, the proverbial elephant in the room, because most people read or regard full-cycle periods as some sort of meta information. In the case of the _South China Sea_, however, non-linearly lower full-cycle periods in the denominator drive accelerations-up. In turn, inertial forces increase as a consequence of higher accelerations.#footnote[Newton's second law of motion.]

Full cycle (motion) periods are given by:

$ T_r = 2pi sqrt( (r_x^2 + m_a_"roll") / (#overline[GM]_T dot g) ) $

$ T_p = 2pi sqrt( (r_y^2 + m_a_"pitch") / (#overline[GM]_L dot g) ) $

$ T_h = 2pi sqrt( (m + m_a_"heave") / (A_w rho g) ) $

These could sometimes be simplified to:

$ T_r = 2pi r_x / sqrt(#overline[GM] dot g) $

$ T_p = 2pi r_y / sqrt(#overline[GM] dot g) $

where,

- $r_x$, $r_y$: radii of gyration along head and beam directions respectively
- $G M_T$, $G M_L$: metacentric height in transverse and longitudinal directions respectively
- $m_a_r$, $m_a_p$, $m_a_h$: added masses

There is a reason full (motion) periods are engineered for manned vessels, which is to make motions humanely _tolerable_ as the graph in @hrvm shows.#footnote[Journee and Pinkster, _Introduction to Ship Hydromechanics_.]

The boundary of depression and intolerable ranges can occur for very low accelerations, if periods are too low. Whereas a combination of acceleration and its corresponding average frequency of oscillation determines the level of comfort aboard.

However, marine cargo transports often involve unmanned dummy barges, for which human response is not seen as a governing requirement, and are therefore acceptable to operate at lower periods of motion. High dynamic acceleration is often a result of small period of motion, as seen in the case of _South China Sea_ pertaining to unmanned cargo barges.

#figure(
  image("/img/tow_hra.png", width: 75%),
  caption: [Human response to vessel motions],
) <hrvm>

One way to manage this is by optimising (static) metacentric height, #smallcaps[gm], by keeping it sufficiently high from greater initial stability considerations --- but not excessively high, to warrant low periods of motion. This would not only reduce dynamic accelerations, but also help improve human response, where essential.

== Effect of cargo position on inertia forces

The effect of cargo position on sea-transport forces in unrestricted open-seas (in terms of _W_, which is the dry weight of cargo)for all vessel types described in 0030/ND is shown in @lv, @mv, @sb, and @sv.

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

#pagebreak(weak: true)

The plot script for all standard vessel types, described in 0030/ND is as follows.

#let ves = read("/src/ves.py")
#{linebreak();raw(ves, lang: "python")}

For non-standard motion responses, particularly in benign environments that exhibit lower single amplitude motion and lower full-cycle period, the following code could be used. It requires all values to be input.

#let ves_c = read("/src/ves_c.py")
#{linebreak();raw(ves_c, lang: "python")}

$ - * - $
