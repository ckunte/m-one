= Mapping dynamics

While sifting through some of my files yesterday, I found a spread-sheet using Gaussian elimination technique@spottiswoode_gaussian, refreshing old memories. In 2004, we were engineering a SPAR + topside --- the first of its kind for the region. For transport, we designed the topside to straddle atop two lean barges --- like a catamaran. This enabled the topside to be floated over, and mate with the SPAR.

We quickly realised that the catamaran arrangement was a stiffness hog for the topside during tow (racking moments resulting from quartering seas) --- driving the need for more steel in the topside, far more than in its in-service conditions.#footnote[US 8312828 B2 patent, _Pre-loading to reduce loads and save steel on topsides and grillage of catamaran systems_,@luo_us8312828b2 describes the measures we took to save steel.]

Marine team furnished motion-induced dynamic loads of the catamaran barge ensemble (from motion responses) for  topside stress check during its fourteen-day tow. To transfer these on to the topside as inertia loads, we did the following:

+ First, we converted the dynamic loads into topside coordinate system along with sign conventions.
+ Then, we generated inertia loads on topside corresponding to 1.0g of linear (surge, sway, heave) and angular accelerations (roll, pitch, yaw), which resulted in a load case each --- six in total, with each containing loads (Fx, Fy, Fz) and moments (Mx, My, Mz).
+ From the two above, the idea was to get suitable factor to apply to the loads generated in step 2 to match the dynamic loads received from the Marine team --- using the Gaussian elimination technique.

Upon solving the following grid, we'd end up with six load factors to multiply with our set of six inertia load sets respectively.

#set math.mat(delim: "[")
$ mat(
  F_"x1",  F_"x2",  F_"x3",  F_"x4",  F_"x5",  F_"x6", dots.v, F_x;
  F_"y1",  F_"y2",  F_"y3",  F_"y4",  F_"y5",  F_"y6", dots.v, F_y;
  F_"z1",  F_"z2",  F_"z3",  F_"z4",  F_"z5",  F_"z6", dots.v, F_z;
  M_"x1",  M_"x2",  M_"x3",  M_"x4",  M_"x5",  M_"x6", dots.v, M_x;
  M_"y1",  M_"y2",  M_"y3",  M_"y4",  M_"y5",  M_"y6", dots.v, M_y;
  M_"z1",  M_"z2",  M_"z3",  M_"z4",  M_"z5",  M_"z6", dots.v, M_z;
) $

Back to the spreadsheet, I noticed that we had actually generated a multiple pivot-eliminate routines through iterations, until all coefficients (except the principal diagonal) were decomposed, and coefficients in the principal diagonal contained 1 each --- as is done in the technique. 

Matrices are now available in most modern computing software. Gaussian elimination, on the other hand, was perhaps from an era of logarithms and radians --- designed to simplify computational complexity when done by hand. So, I am not sure why we used this technique, in lieu of matrix functions in Excel or MathCAD available at our disposal.

Following the classic recipe of solving linear equations ($A dot x = B$) for x, a column matrix of load factors, where $A$ is a square matrix of inertia loads --- corresponding to 1.0g, and $B$ is a column matrix of dynamic loads from catamaran's motion responses, I punched in the two arrays to see if I could get the same set of $x$. 

#pagebreak(weak: true)

Here's how simple it is with numpy.

#v(1em)

```python
#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
mat.py -- 2015 ckunte.
"""
import numpy

def main():
    # Inertia matrix, A, corresponds to 1.0g in surge, sway, 
    # heave, roll, pitch, and yaw.    
    A = numpy.mat("[-11364.0, 0.0, 0.0, 0.0, -412.3, -9.1; \
        0.0, -11364.0, 0.0, 412.3, 0.0, -9.9; \
        0.0, 0.0, -11364.0, 9.1, 9.9, 0.0; \
        0.0, 231661.7, 5129.7, -11569.7, 322.5, 266.6; \
        -231661.7, 0.0, 5574.3, 322.5, -15050.3, -239.8; \
        -5129.7, -5574.3, 0.0, 266.6, -239.8, -8929.5]")
    # Motion-induced dynamic loads (one of numerous cases)
    B = numpy.mat("[-2961.0; -1358.0; -40613.0; 119921.5; \
    -68588.5; 210347.9]")
    # getI() is the matrix inverse function from numpy.
    x = A.getI() * B
    print x

if __name__ == '__main__':
    main()
```

The output looks like below --- matching the result we'd obtained from Gaussian elimination method:

```bash
$ python mat.py
[[  0.16090823]
 [ -0.71351288]
 [  3.55783674]
 [-23.53602482]
 [  3.27622169]
 [-23.99421225]]
```
