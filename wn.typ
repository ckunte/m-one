#import "inc/_template.typ": *
#let mytitle = [worknotes]
#show: book.with(
  title: mytitle,
  author: "C Kunte",
  dedication: [for Aaryana _&_ Saanvi],
  publishing-info: [
    #include("/inc/pub.typ")
  ],
)

#outline(
  indent: 1em, 
  depth: 2
)

#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)

#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
)
// Abbreviations (fix to indenting bug yet to be released)
// #include "/inc/abbreviations.typ"

// preface
#include "/inc/_preface.typ"

// sea-transport and inertia
#include "/inc/tow.typ"
#include "/inc/reac.typ"
#include "/inc/unconditional.typ"

// fatigue
#include "/inc/tsa.typ"
#include "/inc/sncurves.typ"

// wind and wave
#include "/inc/wind.typ"
#include "/inc/wavelength.typ"
#include "/inc/viv.typ"

// stability and utilisation
#include "/inc/slenderness.typ"
#include "/inc/ebs.typ"
#include "/inc/cosfunc.typ"

// reliability and storm safety
#include "/inc/reliability.typ"
#include "/inc/stormsafety.typ"

// nearshore
#include "/inc/fenders.typ"

// installation and lifting
#include "/inc/jf.typ"
#include "/inc/crane.typ"
#include "/inc/impact.typ"

// model
#include "/inc/model.typ"

#pagebreak()
