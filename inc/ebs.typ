= Shell buckling


I have been evaluating the size of flotation tanks needed to install a large jacket substructure. The circular cylindrical tank sections in my case have a D/t ratio upwards of 300 --- too slender and non-compact to withstand severe buckling hazard under stress. Thin walled large tanks such as these are typically reinforced with uniformly-spaced internal ring frame stiffeners. And so I have been testing to see what ring frame stiffener spacing would be reasonable to maintain sufficient buckling strength for this tank to perform its job as intended, which is to safely assist in floating, upending and in setting-down the jacket structure on sea-bed.

#figure(
  image("/img/lfE_6000x20.svg", width: 93%),
  caption: [
      Effect of ring frame spacing (l) on the buckling strength of a flotation tank, based on DNVGL-RP-C202
  ]
) <lfe>

For each of the eight hundred ring frame spacing variations, this little script generates elastic buckling strengths for (a) axial stress, (b) bending, (c) torsion and shear force, (d) lateral pressure, and (e) hydrostatic pressure respectively --- all in one go. And it powers through this in 1.0s. The bottleneck is not the speed at which it does this but in validating the results I do by hand for one or two unit values.

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ebs.py -- Elastic buckling strength of un-stiffened circular cylindrical 
shell for a range of distances between ring frame stiffeners, based on 
DNVGL-RP-C202 (2019), 2020 ckunte
"""
import numpy as np
import matplotlib.pyplot as plt


def bcoeff_ebs(D, t, l):
    # Mechanical properties of structural steel
    # Poisson's ratio
    nu = 0.3
    # Young's modulus (MPa)
    E = 2.1e5
    # Mid-plane radius of cylindrical tank
    r = 0.5 * (D - t)
    # The curvature parameter
    Z_l = (l ** 2 / (r * t)) * np.sqrt(1 - nu ** 2)
    """
    Buckling coefficients (psi, xi, rho) for un-stiffened
    cylindrical shells, mode (a) shell buckling from Table 3-2,
    Buckling strength of shells, DNVGL-RP-C202 (2019) for:
      (a) axial stress,
      (b) bending, 
      (c) torsion and shear force, 
      (d) lateral pressure, and 
      (e) hydrostatic pressure respectively
    """
    psi = [1.0, 1.0, 5.34, 4.0, 2.0]
    xi = [
        (0.702 * Z_l),
        (0.702 * Z_l),
        (0.856 * np.power(Z_l, 0.75)),
        1.04 * np.sqrt(Z_l),
        1.04 * np.sqrt(Z_l),
    ]
    rho = [
        (0.5 * np.power((1 + r / (150.0 * t)), -0.5)),
        (0.5 * np.power((1 + r / (300.0 * t)), -0.5)),
        0.6,
        0.6,
        0.6,
    ]
    """
    For each array of [psi, xi, rho] coefficients, compute reduced 
    co-effcient (C) elastic buckling strength of un-stiffened cir-
    cular cylindrical shell (f_E)
    """
    C = []
    f_E = []
    for i, j, k in zip(psi, xi, rho):
        # Reduced buckling coefficient, see equation 3.4.2, DnV-RP-C202
        c = i * np.sqrt(1 + (k * j / i) ** 2)
        C.append(c)
        """
        Elastic buckling strength, see equation 3.4.1, DnV-RP-C202
        Also applicable to:
            Torsion and shear force when 
                (l / r) < 3.85 * sqrt(r / t)
            Lateral / hydrostatic pressure when 
                (l / r) < 2.25 * sqrt(r / t)
        """
        f_e = (
            c * (np.pi ** 2 * E / (12.0 * (1 - nu ** 2))) * (t / l) ** 2
        )
        f_E.append(f_e)
    """
    Replace values of elastic buckling strength from f_E list 
    for long cylinders for torsion and shear force:
    """
    if any(l / r) > (3.85 * np.sqrt(r / t)):
        f_E[2] = 0.25 * E * np.power((t / r), 1.5)
        pass
    """
    Replace values of elastic buckling strength from f_E list 
    for long cylinders for lateral / hydrostatic pressure:
    """
    if any(l / r) > (2.25 * np.sqrt(r / t)):
        f_E[3] = 0.25 * E * np.power((t / r), 2)
        f_E[4] = f_E[3]
        pass
    # any() is used (in above conditionals) as "l" is an iterable list
    return C, f_E


def ebs_plot(D, t, l):
    # Call only the C list (not used)
    C = bcoeff_ebs(D, t, l)[0]
    # Call only the f_E list
    f_E = bcoeff_ebs(D, t, l)[1]
    # Plot labels
    lbl = [
        "$f_{Ea}$ for axial stress",
        "$f_{Em}$ for bending",
        "$f_{Et}$ for torsion and shear",
        "$f_{El}$ for lateral pressure",
        "$f_{Eh}$ for hydrostatic pressure",
    ]
    # Generate plots
    for i, j in zip(f_E, lbl):
        plt.plot(l, i, label=j, linewidth=2)
        pass
    plt.xlabel("Distance between ring frames, l (mm)")
    plt.ylabel("Elastic buckling strength, $f_E$ (MPa)")
    plt.title(
        "Un-stiffened circular cylindrical shell (%d$\\times$%d)"
        % (D, t)
    )
    plt.grid(True)
    plt.legend(loc=0)
    plt.savefig("lfE_%dx%d.svg" % (D, t))
    plt.close()
    pass


def main():
    # -- USER INPUTS --
    # Size of circular cylindrical tank (mm)
    D = [6000.0]
    t = [20.0]
    # Distance between ring frames (mm)
    l = [np.arange(400.0, 1200.0, 1.0)]
    # -- END of USER INPUTS --
    for i, j, k in zip(D, t, l):
        ebs_plot(i, j, k)
    pass


if __name__ == "__main__":
    main()
```

$ - * - $