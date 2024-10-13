= Cosine interaction

While reviewing the changes introduced in the new ISO 19902:2020 standard@iso19902_2020, this one jumped at me:

#quote()[
  tubular member strength formulae for combined axial and bending loading now of cosine interaction form instead of previously adopted linear interaction;  
]

In ISO 19902:2020, the combined unity check for axial (tension | compression) + bending takes the following general expression:

$ U_m = 1 - cos(pi / 2 (gamma_(R,t|c) sigma_(t|c)) / f_(t|y c)) + (gamma_(R,b) sqrt(sigma^2_(b,y)) + sigma^2_(b,z)) / f_b $

This form of unity check has existed since 1993 in API RP-2A LRFD@api_rp2a_lrfd, 1st edition, and whose introduction into ISO 19902:2020 is briefly described in $section$A13.3.2 and $section$A13.3.3. This form makes its presence felt throughout _$section$13 Strength of tubular members_.#footnote[This form, i.e., 1 - cos(x) occurs in as many as eleven equations, viz., Eq. 13.3-1, 13.3-2, 13.3-4, 13.3-8, 13.3-18, 13.3-19, 13.3-21, 13.3-23, 13.4-7, 13.4-13, and 13.4-19 in ISO 19902:2020. Curiously, this is not applied to dented tubes in §13.7.3, whose combined UC expression(s) remains like before.]

Previously, _Um_ in ISO 19902:2007 was expressed as:

$ U_m = gamma_(R,t|c) sigma_(t|c) / f_(t|y c) + gamma_(R,b) sqrt(sigma^2_(b,y) + sigma^2_(b,z)) / f_b $

The reduction of _Um_ in the first equation is notable, see Figure below. For example, if the axial unity check value (x) is, say, 0.2, then its contribution is reduced to $0.05 (= 1 - cos(pi / 2 x)$. Remember `cos()` is in radians.

#figure(
   image("/img/tuc_under_cosint.svg", width: 100%),
   caption: [
     Axial utilisation versus axial component under cosine interaction in the combined utilisation expression
   ]
) <cf1>

#let cosint = read("/src/cosint.py")
#{linebreak();raw(cosint, lang: "python")}

$ - * - $