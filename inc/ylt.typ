= Web plate size in direct tension using the yield line theory

The relationship between the total ultimate tension $P_u$ and thickness for a web plate with _fixed_ ends is given by @Puf. For a web plate with _supported_ but not fixed ends, it is given by @Pus, see ref.@rhk.

$ P_u_"fixed" = ((F_y t_w^2) / (e b)) (2b^2 + 2e^2 + c b + L e) $ <Puf>

$ P_u_"supported" = ((F_y t_w^2) / (e b)) (2b^2 + e^2 + c b + (L e) / 2) $ <Pus>

See @wpp for other parameters referenced in @Puf and @Pus.

#figure(
  image("/img/ylt-legend.png", width: 67%),
  caption: [Web plate parameters (courtesy: R.H. Kapp~@rhk)]
) <wpp>

#pagebreak(weak:true)

/ Sample problem: b = 64mm, c = 0mm, e = 64mm, and L = 110mm

#figure(
  image("/img/Pvt_fixed_ends.svg", width: 87%),
  caption: [Min. web plate size (fixed ends) versus the total ultimate tension]
) <fpuf>

#figure(
  image("/img/Pvt_supported_ends.svg", width: 87%),
  caption: [Min. web plate size (supported ends) versus the total ultimate tension]
) <fpus>

#pagebreak(weak:true)

#let ylt = read("/src/ylt.py")
#{linebreak();raw(ylt, lang: "python")}
