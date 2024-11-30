= Reliability

The application of reliability concepts to offshore structures began as an American story. In 1979, under the direction of Dr. Fred Moses, the American Petroleum Institute began a series of studies to implement reliability design procedures for fixed offshore platforms. This would (a) offer greater uniformity in platform component reliability; (b) enable a more effective material utilisation; (c) directly account for randomness and uncertainties in engineering parameters; (d) be capable of consistent modifications to account for different location, platform type, and life; (e) offer a logical basis for incorporating new information; and (f) help to focus on research activities to emphasise areas of greatest uncertainty and have results impact reliability factors.

PRAC 79-22 Project recommended that API RP-2A standard should change its current method of checking component safety known as working stress design (WSD) format to a multiple safety factor format. This concept came to be known as the Load Resistance Factor Design or LRFD.

To illustrate this in WSD, a component is checked with an equation of the form:

$ sigma_n / gamma > Sigma sigma_i $

where, $sigma_n$ is the nominal strength, $gamma$ is safety factor, and $sigma_i$ is nominal load.

Notice only one safety factor is used in the above, and hence the reliability would depend on the range of design application. Whereas, in the LRFD approach, partial safety factors are used in the format:

$ phi sigma_n > Sigma gamma_i sigma_i $

where, $phi$ is component factor, $Sigma gamma_i sigma_i$ is the sum of factored loads.

The research that went into producing this method included the following steps:

+ Gather statistical data on load effects and component strengths.
+ Review present performance criteria and experience.
+ Establish target reliability level for each component type, based on performance experience.
+ Calibrate load and resistance factors for tabulation in the standard.

PRAC 80-22 Project defined the reliability model for a structure as one that should incorporate safety margins and uncertainties in evaluating risk to a component or system.

The probability of component failure is as shown in @apil.

$ "Risk" 
    &= 1 - "Reliability" \
    &= P_("failure") \
    &= "Strength" < "Load"
$

The (extreme) load frequency curve overlapping the strength curve represents the risk.

#figure(
  image("/img/pf.jpg", width: 100%),
  caption: [Probability of failure curves (courtesy: API)]
) <apil>

The model is viewed as a situation in which the probabilities correspond to the worst loading case --- annual or lifetime, as appropriate. This overlap (i.e., probability of failure) would decrease if either (i) the mean margin of safety increases, or (ii) the uncertainty ($sigma$) in load or resistance reduces.

The analysis of reliability is carried out by defining a failure function, _g_, such that _g < 0_ denotes failure, or 

$ g = R - E $

where, 

- R -- resistance or capacity,
- E -- load effect

An exact solution for the probability of failure, $P_f$, could be obtained if R and E are both assumed as normal distributions with respective mean values, R and E, and coefficients of variations (cov),#footnote[The COV is the standard deviation divided by mean value.] $V_R$, and $V_E$. Using these assumptions, $P_f$ can be written as:

$ P_f 
    &= Phi(- macron(g) / sigma_g)
    &= Phi(-beta)
$

where,

$ Phi(x) = integral_(-oo)^(oo) 1 / (2pi) e^((-1/2 z^2) d z) $

However, normal distributions are not always applicable to both load and strength variables, and both R and E in turn depend on several other random variables, such as load type (gravity, wave), beam-column stability, combined hydrostatic, axial and bending strengths, etc. Therefore, a generalisation is needed to carry out realistic reliability analyses. These results are often described in terms of a safety index, $beta = macron(beta)$ / $sigma_g$, i.e., the ratio of mean safety margin to uncertainty level. In other words, $beta$ is the distance in terms of standard deviations ($sigma_g$) from the mean ($macron(beta)$) of the safety margin to the failure region (g < 0). When expanded, the expression becomes:

$
beta = ln(R_m / E_m sqrt((1 + V_E^2) / (1 + V_R^2))) / sqrt(ln[(1 + V_R^2) dot (1 + V_E^2)])
$

Based on the GoM database, the following were derived, viz., 

$ 
R_m = 1.85 \
gamma_E = 1.35 \
"cov"_R = 0.05 
$

Using these above together with $E_m$ and $V_E = sqrt(0.32^2 + 0.08^2)$), the safety index, $beta_("GOM")$ was computed to be 2.77, for a reference period of 20 years --- based on a characteristic 100-y design event. (From $beta$, $P_f$ could be determined as 4E-4/y for the GoM database.)

Further, it was noted that the mean RSR is proportional to $gamma_E$, which resulted in the expression:

$ R_m 
    &= 1.85 / 1.35 dot gamma_E \
    &= 1.37 dot gamma_E 
$

The LRFD method caught-on. Shell engineers extended the concept to numerous geographical areas#footnote[Efthymiou, M., et al., _Reliability-based Criteria for Fixed Steel Offshore Platforms_, Transactions of the ASME, Vol. 119, May 1997.] to develop @lnd.

#figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      inset: 10pt,
      align: horizon,
      [_Area_], [_MPM_], [_Mean_], [_COV ($sigma_E$)_], [_$V_E$_],
      [GoM]     , [0.68], [0.79], [0.25], [0.32],
      [NNS]     , [0.75], [0.81], [0.21], [0.265],
      [CNS, SNS], [0.80], [0.84], [0.18], [0.212],
      [AUS]     , [0.67], [0.78], [0.26], [0.33],      
    ),
    caption: [Parameters of lognormal distribution of extreme 20-year load in various geographical areas (E=1.0 corresponds to $E_(100)$)],
) <lnd>

where, $E_20$ is the most probable value, and $E_(20m)$ is the mean value. In addition to $V_E$ provided above, uncertainty in hydrodynamic areas, volumes and marine growth, must be accounted for. This effect is covered by using COV = 8% and a bias factor of 1.0 (= ratio of mean value to characteristic value). This COV must be combined with COV values in table above.

Once this was done, calibrating other locations to Gulf of Mexico safety level became easier. To extend this to a target probability of failure, first a target needed to be defined for the platform type. The industry now generally recognises it to be 3E-5/y for a manned new installation, which would be 6E-4 for 20 years (= 20 $dot$ 3E-5/y).

For the target $P_f$ = 3E-5/y (which corresponds to $P_("f20")$ = 6E-4 "for 20 years"), $beta_(20)$ could be determined as equal to 3.239. Using this safety index, probability density function plots could be generated for all tabulated regions --- as I have done below.

Also, using this new safety index and the table above, the ISO 19902 has tabulated the mean RSR (Rm) and $gamma_E$ for the Australian Northwest Shelf and the North Sea in A.9.9.3. 

So, in a gist, that's the general theory to develop mean RSR and $gamma_E$, which could be applied to new locations, if $E_("mean")$ and $V_E$ could be determined from Metocean and Structural response studies like Shell did in the 90s for its NS and AU assets, and later for its Southeast Asian assets. Of course, statistically extending a dataset of one region's safety index entirely to another depends very much on how well the means and COVs are computed for the new region --- and in general feels both like a novel idea as well as a hack. But for our generation, this will do.

== Partial action factors and reserve strength ratios

Extending the above concept to derive partial action factors and mean reserve strength ratio appropriate to the probability of failure of interest, Shell engineers documented indicative constants to represent key environments.#footnote[Efthymiou, M., van de Graaf, J.W., _Reliability Based Design and Re-assessment of Fixed Steel Platforms_, EP97-5050, February 1997.]
#figure(
  image("/img/expcat-L1.png", width: 120%),
  caption: [Probability density for exposure level L1 ($P_f$ = 3E-5/y)]
) <l1>

Quoting from my colleagues' article, published in Offshore Technology to describe LSM:

#quote()[
  In 1995, Tromans and Vanderschuren introduced the load statistics method (LSM)@tromans_vanderschuren_2002, which uses asymptotic properties of extremes to calculate most probable maxima of the governing responses of a drag dominated (fixed) structure --- overturning moment and base shear. The method uses a simplified response model (i.e., a stick model), allowing the efficient and fast calculation of responses to each sea-state in a long-term hindcast database.

  This enabled analysts to calculate extreme waves, loads and response-based environmental design conditions in the North Sea. The method has been used extensively for the development of response-based design conditions and reliability assessments of fixed structures in the North Sea, Gulf of Mexico and the North-West Shelf of Australia.  
]

#figure(
  image("/img/expcat-L2.png", width: 120%),
  caption: [Probability density for exposure level L2 ($P_f$ = 5E-4/y)]
) <l2>

The LSM tool (from a suite of Metocean tools within Shell) can produce base shears and overturning moments for extreme and abnormal return periods, from which $E_("rp")$ can be calculated. These formulations are from _$section$3.7 Typical Long Term Load Distributions_, EP97-5050@shell_ep97_5050:

$
alpha = (E_("rp") / E_(100) - 1) / (log (r / 100)) \
A = 0.01 dot e^(2.3026 / alpha) \
E_0 = alpha / 2.3026
$

In the above,

- $E_("rp")$ is the ratio of abnormal to extreme storm overturning moment (or base shear),
- $E_100$ is the extreme storm normalised (= 1.0), and
- r is the abnormal return period (say, 10,000 y)

This is useful especially for developing partial action factors for regions, which cannot be represented by any of the above pre-determined regions.

#figure(
    table(
      columns: (1fr, 1fr, 1fr),
      inset: 10pt,
      align: horizon,
      [_Environment_], [_A_],   [_$E_0$_],
        [AUS], [1.342], [0.2041],
   [CNS, SNS], [180],   [0.102],
        [GOM], [2.13],  [0.187],
        [NNS], [11.9],  [0.1411],
[West Africa], [19.235], [0.1322],
    ),
    caption: [Indicative constants representing key environments],
) <rke>

Using these from @rke, $P_f$ could be calculated as follows:

$
P_f = A e^(-R_m / E_0) e^((V R_m)^2 / (2 E_0^2))
$

The easiest way to use the above equation is to pick a range of RSR values in terms of min. and max. (start with, say, an Rm = 1.4) and generate corresponding $P_f$ at every small $R_m$ interval until it exceeds 3E-5/y (33,333 years = 1 / 3E-5/y). In the plots below, the green (dashed) line indicates 2,000 years, which corresponds to $P_f$ = 5E-4/y (L2), and the blue (dashed) line marks 33,333 years, which corresponds to $P_f$ = 3E-5/y (L1). Here's a summary of results.

#figure(
    table(
      columns: (1.25fr, 1fr, 1fr, 1fr, 1fr),
      inset: 10pt,
      align: horizon,
      [], [_$R_m$_], [_$gamma_E$_], [_$R_m$_], [_$gamma_E$_],
      [$P_f$], [3E-5/y], [3E-5/y], [5E-4/y], [5E-4/y],
        [AUS], [2.27],   [1.65],   [1.66],   [1.21],
   [CNS, SNS], [1.69],   [1.23],   [1.37],   [1.00],
        [GOM], [2.17],   [1.59],   [1.60],   [1.17],
        [NNS], [1.90],   [1.39],   [1.47],   [1.08],
[West Africa], [1.86],   [1.36],   [1.46],   [1.06],
    ),
    caption: [
        Mean reserve strength ratio (Rm) and corresponding partial action factor ($gamma_E$) for probabilities of failure 3E-5/y (i.e., 33,333 year return period) and 5E-4/y (i.e., 2,000 year return period) respectively
    ],
) <rm>

One may notice some values in @rm that are either similar or close to those listed in $section$A.9.9.3.3, ISO 19902:2007.#footnote[Note, this section has been eliminated in the latest ISO 19902:2020 version.]

#figure(
  image("/img/pra-2.svg", width: 96%),
  caption: [
    Return period v. Reserve strength ratio
  ]
) <pr2>

#figure(
  image("/img/pra-1.svg", width: 96%),
  caption: [
    Return period v. Partial action factor
  ]
) <pr1>

#pagebreak(weak: true)

Plot code to generate probability density plots is as follows.

#let rel_pdf = read("/src/rel_pdf.py")
#{linebreak();raw(rel_pdf, lang: "python")}

Plot code to generate $gamma_E$ and corresponding $R_m$ is as follows.

#let rel_pra = read("/src/rel_pra.py")
#{linebreak();raw(rel_pra, lang: "python")}