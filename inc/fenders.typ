= Berthing fenders

To avoid downtime in LNG carrier berthing, I was looking to evaluate the adequacy of breasting dolphins, at an age old jetty, see @bd, coupled temporarily with floating pneumatic fenders (FPF), while new air block fenders (ABF) get procured and replaced.

#figure(
  image("/img/bdolphin.jpg", width: 100%),
  caption: [Aerial view of breasting dolphins],
) <bd>

To assess fenders, I was given performance curves, one that of an ABF from the 70s, and the other of an FPF, furnished by its vendor.

I've put the two together in @fsbs to illustrate how similar they look at first glance, while in fact, how different they actually are. Sharp eyes will quickly notice the inconsistent units, unequal ordinates, and interchanged twin-axes. It's obvious that I needed to put all these four curves on to a single graph to avoid optical illusion. 

#figure(
  image("/img/abfpf.jpg", width: 80%),
  caption: [ABF, FBF performance curves],
) <fsbs>

#figure(
  image("/img/cf.png", width: 80%),
  caption: [Fender performances],
) <fc>

With no data except for these plots, I had to digitize, convert to consistent units, and interpolate between data points to generate this following comparison in @fc. Note the effect units have over curve-slopes. By visual inspection of the first image alone, I'd not have picked up the fact that ABFs perform by a factor of 4 over FPFs at their respective maximum deflections, and by a factor of 2 at equivalent deflections. Also that FPFs are demonstrably softer than ABFs. And just for fun, I've also added cell fender type to the mix.

where,

- EVD curves correspond to Energy v. Displacement,
- RVD curves correspond to Reaction v. Displacement

Code for plotting performance curves of air block, floating pneumatic and cell fenders is as follows.

#let pcurves = read("/src/pcurves.py")
#{linebreak();raw(pcurves, lang: "python")}

$ - * - $
