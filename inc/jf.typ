= Jacket flooding

For a jacket that requires certain buoyancy, assessing its flooding potential can be useful. For instance, it can be a good indicator for operations --- not only in controlled conditions but also to assist in planning to overcome potentially adverse situations during installation, e.g., (a) severe weather forecast, (b) a systemic leak in the flooding system (or closure diaphragms, if used for maintaining buoyancy of components), which in turn may force operations to undertake emergency measures, etc.

In 2012, I was working on a standard that was looking to review reserve buoyancy provisions. The recommended practice then was something like: _"Jacket reserve buoyancy in case of damage shall not drop below 5%."_

Comforting text? One that gives you, the client, warm and fuzzy feeling of being in control? You bet. But _are_ you?

The problem with a requirement like that is that it fails to account for the transient nature of the damage. Meaning, once the jacket is floating, you're on the clock, especially if you have either incurred damage or are oblivious to a pre-existing one. Worse still is if you cannot identify the leak, while your pressure indicator begins to dive left. 

Here's a nasty example#footnote[Based on real events.]: Imagine you have a rubber diaphragm that has a leak area equivalent of few square millimetres in its initial state. Once hydrostatic pressure is in play, which is at once the jacket is in water, it would be hard to presume the initial leak area to be static. With a transient metacentre, you're in reactive mode. You want to know how much time you've got before you lose control of the situation.

As I was working to improve the standard, this idea of assessing the time it would take to flood compartments, as a way to assess floatation sensitivity, began twirling in my head. I began with the following:

#quote()[
  Improvements in the industry with regards to robust leg diaphragm design, in which they are tested for twice the design pressure, combined with adequate procedures in-place --- viz., inspection, pressure checks, etc., prior to loadout --- offer a degree of confidence that such an accidental damage can indeed be managed, and that it need not be designed for damage entirely. In support of such a premise, this section makes the case that the time taken to flood a damaged jacket leg, a commonly ignored factor, has the potential to render such a risk to as low as reasonably practicable.

  In order to apply this ALARP premise, the following considerations need to be satisfied: (a) a rigorous inspection and pressure tests of legs, flood valves, and diaphragms are carried out prior to loadout; (b) adequate care is taken to avoid any damage to diaphragms and flooding valves during tow; and (c) any damage that may yet incur, may not be obvious to visual inspections, otherwise it would still be possible to consider mitigation prior to lowering the jacket in water. Under such circumstances, the time taken to flood a damaged jacket may be calculated as a way to understand the residual risk.
]

I then went on to offer a recipe to assess it, which is basic hydraulic theory in essence, and is as follows:

The time taken (in seconds) to flood volume _V_ is given by:

$ t = V / Q $

where, _Q_ is the rate of water ingress of a given hole diameter, which is expressed as:

$ Q = v A_r $

where, $A_r$ is the effective hole area $m^2$, and _v_ is the velocity of water ingress (in m/s), which is given by:

$ v = mu sqrt(2 g h) $

where, $mu$ is the frictional coefficient of the orifice (hole) edge, _g_ is the acceleration due to gravity (in $m/s^2$), and _h_ is the hydrostatic head (in m).

Here is an example of a problem I've been working recently on.

#figure(
  image("/img/Dvt.svg", width: 120%),
  caption: [Time taken to flood jacket components for a range of hole diameters],
) <dvt>

Unbeknownst to me, it seems this was a problem that was explored by Naval Architects --- bless this community of hard-working engineers, who unfailingly punch well above their weights --- as far back in 1991 in the context of stability of sailing vessels. The theory@deakin_1991, underpinned by hydraulics, checks-out of course.

An approach similar to this in managing risk was applied to Liwan 3-1 the largest fixed jacket in the Asia-Pacific region@yu_2013, which together with the success of North Rankin B continues to inspire engineers like myself looking to overcome challenges similar or greater than the ones experienced by such projects.

#let jf = read("/src/jf.py")
#{linebreak();raw(jf, lang: "python")}

#v(1em)

/ Important Note: This is a stop-gap assessment, of course, and by itself it is never sufficient. (Ideally, a full blown time-domain analysis is recommended to pre-determine the time available.) Aside from testing the flooding system, supplemented by control and auxiliary features, one needs to at least ensure that flood-able compartments are divided into controllable volumes to be able to limit accidental flooding exposure to have any degree of control.#footnote[This may not be practical for pile through leg jackets.]