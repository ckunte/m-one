= Building a model

#figure(
  image("/img/model.png", width: 100%),
  caption: [
    Building this model from scratch with error-checking, testing for integrity, and preparing for pushover
  ]
) <model>

A few months ago, I found the need to rebuild a complex finite element model of a jacket substructure. This was after exhausting the option of modifying one built by an agency. I needed to shift two of jacket's horizontal frames in the water column, and move to re-align all associated frames and elements. Thereafter port the model to USFOS@holmas_usfos_theory error-free, re-code loads, hydrodynamic properties, marine growth, and re-attach foundation model before proceeding to perform a series of non-linear progressive collapse analyses.

Every time I tried modifying the geometry of the existing model, I found the highly fragmented launch truss in my way. The more I tried changing it, the more I found it exhausting and frustrating. But I dreaded building one from scratch more. For one, the existing model was built by a team of engineers, had undergone rigorous quality control, and was the foundation upon which an entire phase of the project was engineered. In other words, I was not sure I'd do any better than this team. And two, it's been years since I built one from ground up, and so it was going to test my rusty skills, and it would hammer my confidence if I failed.

On building a model, Dr Holmas once said to me:

#quote()[
  _Build your computer model like you would build a scaled physical model with details relevant and sufficient (no less and no more) to undertake model testing._
]

It's common sense, of course, but in reality give man a sophisticated piece of software only to watch him get himself entangled in complexity. People build the most complex models even when all they need is a simple one. That said, it is hard not to empathise with teams that work under tremendous time pressures, and there are no credits for creating task-specific models. Instead, teams build one that can be used and re-purposed for performing a series of tasks.

Fortunately, my task is always specific --- concept development, stress-testing asset integrity, design optimisation, or trouble-shooting. So Dr Holmas's words have since been guiding me.

Planning my approach on building a model first on a piece of paper was therapeutic, and I set myself ample time, just to be consoled that I had the time necessary to build one needed for the task. In the process, I re-discovered that symmetry is your friend, which helps one produce error-free replicable and merge-able geometry. The planning allowed me to identify parts of the structure I could replicate. The first part (a two-dimensional frame) I actually built using a spreadsheet --- by mapping key coordinates, and then exporting it to a comma separated file.

```
Label, ID, X, Y, Z
NODE,4,-15.0,-23.50,-18.0
NODE,5,-15.0,23.50,-18.0
NODE,6,15.0,-23.50,-18.0
NODE,7,15.0,23.50,-18.0
NODE,8,0.0,-36.50,-62.37
...
```
Then I wrote this tiny script to format the above CSV file (say, _part.csv_):

```python
#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
"""Format model data from CSV file
2020 ckunte

Usage: gendata.py --fn=filename.ext
       gendata.py --help
       gendata.py --version

Options:
  --help             Show help screen
  --fn=filename.ext  Furnish datafile, e.g., part.csv
  --version          Show version
"""
from docopt import docopt
import csv
from tabulate import tabulate

args = docopt(__doc__, version="Format model data from CSV file, 0.1")
f = str(args["--fn"])

with open(f, "r") as csvfile:
    alldata = []
    reader = csv.reader(csvfile, skipinitialspace=True)
    for i in reader:
        alldata.append(i)
    print(tabulate(alldata, headers="firstrow", floatfmt=".6f"))
```

This would format the _part.csv_ file and produce the following output, which could be copy-pasted (or exported) to a new input file.

```bash
$ python3 gendata.py --fn=part.csv
Label      ID           X           Y            Z
-------  ----  ----------  ----------  -----------
NODE        4  -15.000000  -23.500000   -18.000000
NODE        5  -15.000000   23.500000   -18.000000
NODE        6   15.000000  -23.500000   -18.000000
NODE        7   15.000000   23.500000   -18.000000
NODE        8    0.000000  -36.500000   -62.370000
...
```
The good thing about the script is that it does not care how long your csv file is. For example, if it is less than ten lines, then one would think writing a script to format it is an overkill. But if it is made up of hundreds, then mindless formatting by hand is taxing. So it helps to work smart, while also keeping the edited file error-free.

For parts that had complex geometric transitions, I ended up modelling these in SACS first as SACS Precede has excellent modelling features. In aggregate 25% of the model was built by hand and the rest by replication --- via copying, mirroring, and offsetting. In the part built by hand, I selectively excluded features in the stiffness model that were either not relevant or whose exclusion would not impact the quality of results. The parts excluded from the substructure pushover model, while retaining their self weight, were:

+ Topsides#footnote[While keeping load distribution intact via reactions and moments.]
+ Pile sleeves#footnote[Instead, I modelled piles to be connected directly to the diaphragm plates, which in turn lace jacket legs. I did this to simplify the model, since bond strength between piles and pile sleeves, which is enabled via infill grout, is assumed to be sufficiently developed to not undermine pile-to-sleeve mechanical strength at collapse level loads.]
+ Complex joint cans and conical transition segments within horizontal frames
+ Joint cans for reinforcing braces
+ Certain (secondary) supporting diagonal members
+ Conductor guide frames through the water column
+ Mudmats, and
+ Miscellaneous appurtenances
Many items from the list above could also be excluded because I had prior estimates of loads from the environment (wave, wind, and current), which could be suitably factored without the need to have a full geometry for generating hydrodynamic loading accurately from the simplified model alone. This is not always possible, especially if one does not have the results from a detailed model that could be re-purposed, but in this case, it helped save a substantial amount of time. In the case of the latter, one could still reasonably account for geometry by hand-calculating effective contributions via drag and mass coefficients (_Cd_ and _Cm_ respectively), like so:

$ C_d = Sigma(A_i C_("di")) / A' \
C_m = Sigma(V_i C_("mi")) / V' $

where,

- $A_i$ -- drag area of a component (typically projected),
- $C_("di")$ -- corresponding drag coefficient,
- $A'$ -- drag area of adjusted members (typically projected),
- $V_i$ -- volume of a component, 
- $C_("mi")$ -- corresponding mass coefficient, and
- $V'$ -- volume of adjusted members

Any manual work demands time, and therefore it's a trade-off --- whether to hand-code coefficients or to model the entire geometry. Most time-constrained engineers tend to take the latter route, since it is easier to build geometry than it is to calculate coefficients for adjusted members in at least three directions.#footnote[Drag and inertia coefficients for various shapes are available in &sect;6.8 Hydrodynamic loading, in the seminal book, _Dynamics of Fixed Marine Structures_, Barltrop and Adams, Third Edition, 1991.]

In summary, taking the road generally not taken was both fruitful and satisfying. I could produce comparable results with a substantially simpler model, while also marginally improving its reserve strength in certain directions. Sometimes all that matters is moving the needle a little bit --- in incremental and positive ways that is not only reassuring to the business, but also in building confidence.
