= S-N curves

In order to set a suitable design criteria, I am looking to compare two classes of S-N curves for a fatigue design, viz., E and F2, and I cannot find a handy plot to refer to, and it is frustrating when standards fail to include. So, I channel it to write some code to roll my own:

#figure(
  image("/img/sncurves.svg", width: 100%),
  caption: [
    S-N curves in seawater with cathodic protection based on ISO 19902
  ]
) <snci>

The basic S-N curve equation is as follows, which one may know is from Paris-Erdogan law (fracture mechanics)@paris_erdogan:

#figure(
  image("/img/sncurves-table.png", width: 100%),
  caption: [
    Basic representative S-N curves, ISO 19902
  ]
) <snt>

$ N = k_1 dot S^(-m) $

The standard does describe it in its logarithmic form, which is as follows:

$ log N = log k_1 - m dot log S $

and then it goes on to furnish its two sets of key components that form parts of the equation --- highlighted below. For graphing purposes, the above can also be written as:

$ S = (N / k_1)^(-1 / m) $

For example, and I am writing this for myself since I struggle with logarithms, if

$ log_10 k_1 = 12.18 $

then,

$ k_1 = 10^(12.18) $

Code for plotting hotspot stresses versus number of cycles is as follows.

#let sncurves = read("/src/sncurves.py")
#{linebreak();raw(sncurves, lang: "python")}

== Comparison of S-N curves between standards

+ See #link("http://dx.doi.org/10.13140/RG.2.2.14995.20006")[ISO 19902 and DNV-RP-C203]
+ See #link("http://dx.doi.org/10.13140/RG.2.2.28416.97289")[BS 7608 and DNV-RP-C203]
