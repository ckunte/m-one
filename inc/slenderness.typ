= Tube slenderness

During a pushover simulation last week, the jacket kept struggling at the set load increments. These had not changed from a previous such exercise, the difference being that a particular frame normal to the environmental attack direction had been revised.

#figure(
  image("/img/slenderness.png", width: 100%),
  caption: [Braces buckling when subjected to incremental increase in environmental loading],
) <bb>

When these braces, directly in the line of attack, continued to struggle --- exhibiting excessive displacements in the revised model configuration causing negative matrix errors, I had to re-check their slenderness, even if they did not seem slender at all. 

So back to basics. The criteria for a ductile design, recommended by $section$11.4, ISO 19902@iso19902_2020 is as follows:

$ K L / r lt.eq 80 $

$ lambda lt.eq (80 / pi) sqrt(f_(y c) / E) $

$ f_y D / (E t) lt.eq 0.069 $

From $section$13 of ISO 19902:

$ lambda = K L / (pi r) sqrt(f_(y c) / E) $

$ f_(y c) 
    &= f_y "for" f_y / F_(x e) lt.eq 0.170 \
    &= (1.047 - 0.274 f_y / f_(x e)) f_y "for" f_y / f_(x e) gt 0.170 $

$ f_(x e) = 2 C_x E t / D $

where, 

- $lambda$ -- column buckling parameter
- $C_x$ -- elastic critical buckling coefficient
- D, t, _L_ -- tube size
- E --  modulus of steel elasticity
- $f_y$ -- yield strength of steel
- $f_(y c)$ -- representative local buckling strength of steel
- $f_(x e)$ -- representative elastic local buckling strength of steel

/*
_Quick digression:_ While checking these above expressions for this note, I think I uncovered an error in the latest ISO 19902:2020 standard. Notice the conditional statements in equations 13.2-8 and 13.2-9 in the screenshot below. 

<figure>
  <img alt="Conditional statement error uncovered in Eq. 13.2-9, ISO 19902:2020." class="fig" src="/img/iso19902-2020-err.png">
  <figcaption>Conditional statement error uncovered in Eq. 13.2-9, ISO 19902:2020.</figcaption>
</figure>

<mark>The conditional statement in equation 13.2-9 should instead be _(fy / fxe > 0.170)_</mark>, otherwise both conditionals (i.e., in 13.2-8 and 13.2-9) mean (about) the same. &#x1F643; It looks like an editorial mix-up.

Anyway, back to my braces. 
*/

For a set of brace sizes (selecting one in each bay), the script lets me check their slenderness. And sure enough, three out of the four braces exceed the criteria for ductile design, resulting in premature buckling, as the figure above shows.

#let slenderness = read("/src/slenderness.py")
#{linebreak();raw(slenderness, lang: "python")}

Producing the following:

```
$ python3 sl.py
fy (MPa)           = 400.0
D (mm)             = [1300.0, 900.0, 1000.0, 1200.0]
t (mm)             = [50.0, 20.0, 20.0, 30.0]
L (mm)             = [20518.0, 52151.0, 59685.0, 77500.0]
A (mm^2)           = [196349.5, 55292.0, 61575.2, 110269.9]
I (mm^4)           = [38410878928.7, 5355033173.6, 7395183442.8, 
                       18880963994.1]
r (mm)             = [442.295, 311.207, 346.555, 413.793]
fxe (MPa)          = [4730.769, 2733.333, 2460.0, 3075.0]
fyc (MPa)          = [400.0, 400.0, 400.0, 400.0]
D/t                = [26.0, 45.0, 50.0, 40.0]
KL/r (NTE 80)      = [32.473, 117.304, 120.557, 131.104]
lambda             = [0.457, 1.649, 1.695, 1.843]
lambda (NTE)       = [1.125, 1.125, 1.125, 1.125]
fyD/Et (NTE 0.069) = [0.051, 0.088, 0.098, 0.078]
```

From above results, clearly the only member that is not considered slender is the one with size, 1,300$times$50$times$20,518. The last three tubes exhibit some form of slenderness --- mostly on account of length, and may warrant suitable resizing.

The lambda is python's built-in anonymous function I use to power through lists, which should not be confused with $lambda$ -- the column buckling parameter, the latter corresponds to `lmbda` in the script --- note the intentional spelling change to avoid the built-in function clashing with the formula.

$ - * - $
