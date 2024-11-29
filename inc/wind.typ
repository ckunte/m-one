= Wind

The following offers a way to visualize wind profile for a given $U_o$ and $t$ for a range of heights up to a maximum of $h$.

== Based on ISO 19901-1:2005@iso19901-1_2005

#figure(
  image("/img/isowind.svg", width: 100%),
  caption: [Wind as per ISO 19901]
) <iw>

#pagebreak(weak: true)

Plot code to generate @iw is as follows.

#let isowind = read("/src/isowind.py")
#{linebreak();raw(isowind, lang: "python")}

== Probability density function

#figure(
  image("/img/pdf.svg", width: 100%),
  caption: [Probability density function]
) <p1>

Plot code to generate @p1 is as follows.

#let wind_pdf = read("/src/wind_pdf.py")
#{linebreak();raw(wind_pdf, lang: "python")}

== Based on EN 1991-1-4:2005@en1991-1-4_2005

The generic nature of EN's applicability makes for a complicated recipe. The number of things one needs to determine before one even gets to wind velocity is staggering. Here's a flavour of things that come with the territory.

#figure(
  image("/img/enwind.png", width: 100%),
  caption: [PVP, RF, TI, TLS]
) <enw>

Here is the code for these plots.

#let enwind = read("/src/enwind.py")
#{linebreak();raw(enwind, lang: "python")}
