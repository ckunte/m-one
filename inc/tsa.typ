= TSA for pile welds?

During a project schedule review a year ago, citing past experience, I was asked this following:

#quote()[
  _Would the design for pile fatigue warrant applying TSA to pile welds? Any delay in realising this requirement, especially late in fabrication has the potential to adversely affect project schedule._
]

Failing to comprehend, I sought clarification --- for reasons I will get-to in a minute. But first some basics --- to appreciate the complexity of this question, and the rationale behind the response I offered. 

To secure steel infrastructure to seabed, steel piles are commonly used. They are rolled from steel plates in 6m--12m segments and seam-welded longitudinally. For piles requiring lengths greater than stock-rolled lengths, segment ends are welded together.

Submerged steel structures are cathodically protected to prevent them from corroding underwater, and it is common practice to extend this protection to piles either in part or in full, as site conditions demand.#footnote[This depends on the potential for electro-chemical oxidation (i.e., corrosion) below seabed, which further depends on many factors, viz., (a) soil particle size, (b) dissolved oxygen, (c) salinity, (d) pH value, (e) electrical resistance, (f) temperature, etc. The other type, i.e., microbial corrosion, is not discussed here.] The most common cost-effective method of protecting submerged infrastructure below sea surface is by welding blocks of aluminium to steel parts and let saline seawater complete the electro-chemical circuit for ion exchange. This allows aluminium blocks to deplete sacrificially in lieu of corroding steel infrastructure in-place. 

Aluminium can also be used as surface coating by hot-spraying over steel substrate due to its lower melting temperature (about 660$degree$C). To be effective and long lasting, however, thermal sprayed aluminium (TSA) demands greater control over quality and climate during application.#footnote[Humidity below 80%, thickness in microns thereby making this a porous application warranting filler material to cover the porosity resulting from spray, skilled labour, especially if done by hand, temperature controlled, dust-free, contamination-free environments, and stringent surface preparation requirements, etc.]

/ What is TSA?: It is a protective coating of aluminum sprayed over a steel substrate as an alternative method against external corrosion and corrosion under insulation.
  
  In 1981, the US Navy approved the use of TSA coatings as a standard for its ships.@dod_std_2138, @mil_std_2138a

  The first commercial use of TSA coating for offshore platforms in the North Sea area was for flare booms, and in June 1984, Hutton TLP was installed in 146m water depth with tsa coatings on its tethers, risers, and flare boom. Further, on Hutton TLP, the coating was used without a corrosion allowance.@fischer_1995 Whereas for the Heidrun TLP at Haltenbanken in the Norwegian Sea, the design used TSA coating in combination with a corrosion allowance --- this was due to the prevailing regulations at the time that classified TSA as a thin film coating; therefore the splash zone corrosion allowance was provided to meet the safety precautions of the Norwegian Petroleum Directorate Rules and Regulations.

  Inspection after 8-years of exposure showed that the TSA coated area on Hutton TLP remained in very good conditions. A survey carried out by Conoco in 1992@salama_thomason_1984 noted the following:

  + A predicted service life in excess of 30-years for splash zone -- achievable with a 200$mu$ TSA coating applied according the prevailing state of technology. It was assumed that no maintenance would be required.

  + The excellent mechanical and adhesion properties prevent TSA coating from being scraped-off during handling and service (e.g., high pressure water jetting (27.4MPa) for marine fouling removal).

  Within Shell group, the greatest use of tsa is known to be for Troll platform topsides (fabricated by Norske Shell, and operated by Statoil), and its associated land-based installations.

Going back to the question, my inability to grasp what was asked was simply this: what has surface coating, meant for protection against corrosion, got to do with fatigue? Upon asking I received this following feedback from engineers familiar with the case:

#quote()[_We originally specified TSA coating for the piles so that non-seawater S-N curves could be used for the fatigue analysis of the pile girth welds, etc. (Welds are exposed to seawater with no CP during driving.) In the end this requirement was waived and no TSA coating was applied._]

This was so telling that it blew my mind. It suggested that here was a team years ago trying to hack together a solution for a problem they presumably faced, but perhaps without sufficiently understanding corrosion or fatigue (as a phenomenon) or TSA (as a potential solution). 

Let's dive into understanding the problem to see if this was a credible threat first, and then discuss if the solution considered was appropriate.

Corrosion fatigue is a long term phenomenon, since both corrosion and fatigue are, and it is exacerbated by surface roughness and surface temperature, among other things. Metal loss from corrosion in tropical to subtropical seawater temperatures typically ranging 0.2--0.4mm/year.#footnote[Heated surfaces amplify the rate of corrosion by up to ten times.] In other words, it takes years to eventuate. Whereas pile driving in soils (other than in calcarenite) can at worst take a couple of months to complete. The metal loss at the end of, say, three months can at worst be 0.1mm.

#v(1em)
```python
# Corrosion rate
r = [0.2mm/year, 0.4mm/year]

# Metal loss
mloss(t) = map((x * t) in mm, r)

# For, say, a 3-month piling campaign
mloss(3 month) => [0.05 mm, 0.1 mm]
```
#v(1em)

Fearing lack of cathodic protection during driving, and without realising the insignificant threat to pile weld integrity from low metal loss, the team truly believed in the unsubstantiated and therefore unrealistic threat of corrosion fatigue. 

Alternatively, it may be that the performance of these girth welded joints in in-line fatigue were either never comforting to begin with or that it was realised too late --- I am speculating here, since the received feedback does not say. So it is possible that corrosion fatigue was used as a justification. In other words, fatigue may have been a problem all along, just not realistically attributable to corrosion-fatigue. 

It is also possible that the team was looking for S-N curves for seawater without cathodic protection, i.e., for installation case only. Most standards do not offer this, since (a) it does not make sense to offer for such a short installation duration, and (b) there is insufficient specialist data to offer usable coefficients and factors for such a case.

Either way, the team appeared to have a fatigue problem in pile girth welds, and the available stress-cycle curves were not helping in improving design life. This may have led the team to consider non-seawater S-N curves, if they could somehow insulate the joint from seawater --- the surrounding medium.

I am certain that the non-seawater S-N curves were never meant to be used this way, and that the authors of international standards would be suitably shocked if they were made aware of such a use case. But even if we consider this debatable in the vein that unusual circumstances demand unusual methods and therefore merit justification, I am here to say that there are technical reasons why this perceived solution offers neither value nor the desired outcome. To illustrate why, let me first plot S-N curves for tubular joints, since a foundation pile is essentially a tube. Here, I will use the recipe from the ISO 19902 standard @iso19902_2020, but other standards can be considered too, if required.

#figure(
  image("/img/sncurves-tj.svg", width: 100%),
  caption: [
    S-N curves for tubular joints in air and in seawater
    ]
) <tj>

Comparing the two curves in @tj, it is clear that there is not a lot of value here (20--40MPa relief in hotspot stresses) to take the trouble of insulating welds from seawater. I am also here to say that TSA can never offer the sort of insulation, which the team thought it would provide, for two reasons, (a) TSA is a thin-film surface coating whose thickness rarely exceeds 150$mu$ to be effective in adhesion. By virtue of its thickness (or lack thereof) and due to the method of application (i.e., hot metal spraying), the resulting coating is not only porous, but that it requires filler material to cover these pores for it to be effective, and (b) surface roughness is an issue as mentioned earlier. (Welded surfaces are rough unless ground smooth.)

So if this solution isn't a solution at all, and fatigue concerns persisted but were realised very late, then what could be done? Well, there are at least a couple of solutions to improve fatigue life of joints. They are by (a) weld geometry improvement methods (e.g., grinding), and (b) residual stress methods (e.g., peening) with increasing effectiveness. UIT peening#footnote[UIT peening is a cold remoulding of steel / weld by applying uniform stress-relieving controlled blows over the entire welded surface with an ultrasonic hand held gun.] for example is known to improve fatigue life by a factor of four (4). See Table 16.16-1, ISO 19902@iso19902_2020, and Chapter 6 in _Fatigue Handbook_ @fh.

In summary, (a) the threat of corrosion fatigue is one of longer term, and it is unlikely to eventuate during installation, since the duration of installation is too short compared to the rate of corrosion. Once the pile is in the ground, electro-chemical oxidation is significantly reduced from continuing at the aforementioned corrosion rates --- due to limited dissolved oxygen available within the submerged soil. Piles are also CP protected once in the ground through metal to metal contact between substructure and pile(s) for which S-N curves in seawater with CP protection would be applicable; (b) a lot of data in standards is based on research and experimental results, and so using factors and coefficients, derived for one medium, for a completely different medium can have unintended consequences --- depending upon the severity of the problem; (c) attempt to insulate welded joints subsea from seawater using TSA is not a good idea, because TSA is a thin-film porous surface coating whose quality and climate control demands are very high to be effective in cost, functionality, and be schedule-friendly.

I was of course pleased that the story had a better ending, as the feedback suggests, which is that the originally-conceived method to improve fatigue performance was not implemented. 

But before I conclude, let me say this following: I was conflicted for months on whether or not to write this up for the fear of sounding disrespectful, despite best efforts. I deeply respect the candid sharing, and I am indeed grateful for the causal feedback from which we as a community can learn and benefit from. This note should be read in that spirit --- of learning (and helping similarly challenged teams) to resist such temptations in future, and to help realise that there are least one or two solutions for managing fatigue,#footnote[Even if the asset is in the later stages of being fabricated.] but that TSA is not one of them.

The code to generate @tj is as follows.

#let tj_curve = read("/src/tj_curve.py")
#{linebreak();raw(tj_curve, lang: "python")}