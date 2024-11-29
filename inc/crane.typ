= Offshore crane

API Spec 2C@api_spec_2c and EN 13852-1@en_13852_1 are two well known standards that offer guidance in developing minimum offshore pedestal-mounted crane requirements. They represent Gulf of Mexico and the North Sea respectively.

API specification considers Gulf of Mexico to be of "very mild sea and wind conditions" ($section$5.4.4 Legacy Dynamic Method). Environmental conditions in the Gulf of Mexico are indeed mild when hurricanes are excluded. Also, given the unpredictable variation in hurricane strengths and hence the impracticality of designing for such events, offshore facilities in the Gulf of Mexico are operated as _manned-evacuated_. In other words, operations (including crane operations) are suspended and the facility evacuated in the event of an impending hurricane in the facility's path.

When a sizeable number of assets are validated by their use, standards developed primarily for a specific domain find acceptance internationally. However, liberal use is never without a catch, as standards often carry certain domain specific assumptions and criteria that may need revisiting when considered for a domain outside the primary for which it is written and valid for.

Take for instance the primary purpose of offshore cranes mounted on pedestals on offshore platforms --- fixed or floating. They lift cargo and supplies off a floating vessel, which in turn are influenced by incoming waves.

Off-board lift, as API Spec 2C explains, is "the hoisting velocity at the elevation where lift is initiated (i.e., supply boat deck level) shall be fast enough to avoid re-contact after the load is lifted." 

== Off-board lift using API Spec 2C

Minimum required steady hoisting velocity (in ft/s) for off-board lift as per $section$5.4.5.2, API Spec 2C:

For $H_("sig") lt.eq$ 6ft:

$ V_("hmin") = 0.033 + 0.098 dot H_("sig") $

For $H_("sig")$ > 6ft:

$ V_("hmin") = 0.067 dot (H_("sig") + 3.3) $

== Off-board lift using EN 13852-1

Minimum hoisting and lowering velocity (in m/s) for lifting from/to a supply vessel in EN 13852-1 ($section$B.4) is given as follows:

$ V_H = K_H sqrt(V_D^2 + V_C^2) $

where,

- $V_D$ -- vertical velocity of load's supporting deck for lifting to or from a supply vessel (m/s), from Table B.2
- $V_C$ -- vertical velocity of the crane boom tip due to the movement of the crane base (m/s), from Table B.3
- $K_H$ -- velocity factor coving (single fall, multiple fall) reeving and for both no-hook load as well as at rated capacity

$ V_D = (6.0 H_("sig")) / (H_("sig") + 8.0) $

For crane on bottom-founded structures, there is no movement of the crane base, and therefore, $V_C$ = 0.

I wrote a little code to compare the two standards over the weekend (see below) to produce the following graph.

#figure(
  image("/img/vhmin.svg", width: 100%),
  caption: [Comparing minimum hoisting velocities between API Spec 2C and EN 13852-1]
) <cr1>

A couple of observations:

+ API prescription for $V_("hmin")$ covers supply vessels, while EN offers two additional options, viz., barge, and sea surface. (Graphs for barge or sea surface are not shown in the above, but can be separately generated, if desired.)
+ EN is explicit about reeving efficiency --- note the reduced velocity requirements in the case of multi-fall reeving. Looking at the two graphs above, i.e., for API and for EN, the multi-part reeving option appears to be somewhat close to API prescription in terms of $V_("hmin")$. It could be that API considers multi-part reeving efficiency in its prescription, even though it does not mention in $section$5.4.5.2.

Now to the crux of the matter on whether or not a standard's recipe enables safe-clearing of the package lifted before the next wave crest appears. The package travel can be calculated, for a given significant wave height ($H_("sig")$) and corresponding period (T), as follows:

$ h = V_("hmin") dot T $

Testing API Spec 2C recipe for the Australian Northwest Shelf environment:

#figure(
    table(
      columns: (1fr, 1fr, 1fr, auto),
      inset: 10pt,
      align: horizon,
      [$H_("sig")$], [_T_], [$V_("hmin")$], [h],
      [1.4m], [4.9s], [0.14m/s], [0.72m < $H_("sig")$ (Not Good)],
      [2.7m], [5.7s], [0.25m/s], [1.42m < $H_("sig")$ (Not Good)],
      [3.6m], [6.4s], [0.30m/s], [1.98m < $H_("sig")$ (Not Good)],
    ),
    caption: [$V_("hmin")$ based on API Spec 2C],
) <vcr1>

From @vcr1, clearly it does not work. In other words, a lifted package experiences re-contact by the next wave crest before clearing safely. Now let's test this for EN 13852-1 again for the Australian Northwest Shelf environment:

#figure(
    table(
      columns: (1fr, 1fr, 1fr, auto),
      inset: 10pt,
      align: horizon,
      [$H_("sig")$], [_T_], [$V_("hmin")$], [h],
      [1.4m], [4.9s], [0.44m/s], [2.19m > $H_("sig")$ (OK)],
      [2.7m], [5.7s], [0.75m/s], [4.31m > $H_("sig")$ (OK)],
      [3.6m], [6.4s], [0.92m/s], [5.96m > $H_("sig")$ (OK)],
    ),
    caption: [$V_("hmin")$ based on EN 13852-1],
) <vcr2>

From @vcr2, it can be seen that the recipe offered by EN 13852-1 clears the package comfortably before the next wave crest arrives. So EN's recipe works for NWS where API's does not.

Code for generating @cr1 is as follows.

#let vhmin = read("/src/vhmin.py")
#{linebreak();raw(vhmin, lang: "python")}

IOGP specification S-618@iogp_s618 issued in Dec 2018 now fixes the low velocity in API's off-board lift recipe, which stuck out like an anomaly#footnote[To be sure, my interest in API Spec 2C is now academic, and I am not judging it for its merits or demerits, since API's application domain is primarily the US. However, due to the fact that API standards are generally good to very good that the engineering community tends to adopt them across domains (outside USA) --- sometimes without pausing to consider whether or not cross-domain application is appropriate.], see plot above, and is now in step with that of EN 13852-1, which can be seen in the updated plot below.

#figure(
  image("/img/vhmin_iogp.svg", width: 100%),
  caption: [
  Crane (off-board) hoisting velocity updated with IOGP S-618 recommendations
  ],
) <ci8>

Code for generating @ci8 is as follows.

#let vhmin_iogp = read("/src/vhmin_iogp.py")
#{linebreak();raw(vhmin_iogp, lang: "python")}