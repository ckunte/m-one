= Shell buckling

I have been evaluating the size of flotation tanks needed to install a large jacket substructure. The circular cylindrical tank sections in my case have a D/t ratio upwards of 300 --- too slender and non-compact to withstand severe buckling hazard under stress. Thin walled large tanks such as these are typically reinforced with uniformly-spaced internal ring frame stiffeners. And so I have been testing to see what ring frame stiffener spacing would be reasonable to maintain sufficient buckling strength for this tank to perform its job as intended, which is to safely assist in floating, upending and in setting-down the jacket structure on sea-bed.

#figure(
  image("/img/lfE_6000x20.svg", width: 93%),
  caption: [
      Effect of ring frame spacing (l) on the buckling strength of a flotation tank, based on DNVGL-RP-C202@dnvgl_rp_c202
  ]
) <lfe>

For each of the eight hundred ring frame spacing variations, this little script generates elastic buckling strengths for (a) axial stress, (b) bending, (c) torsion and shear force, (d) lateral pressure, and (e) hydrostatic pressure respectively --- all in one go. And it powers through this in 1.0s. The bottleneck is not the speed at which it does this but in validating the results I do by hand for one or two unit values.

#let ebs = read("/src/ebs.py")
#{linebreak();raw(ebs, lang: "python")}
