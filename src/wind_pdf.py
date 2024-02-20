#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
wind_pdf.py: 2016 ckunte
"""
import numpy as np
import matplotlib.pyplot as plt

def main():
    # Weibull distribution: probability distribution function 
    # (for extra-tropical storms)
    ## -- begin inputs --
    ls = [1.0, 1.12] # Mean / nominal speed
    lf = [0.78, 0.94] # Mean / nominal force
    ## -- end inputs ----

    k = 5. # Safety index

    x = np.linspace(0.,2.5)

    for i, j in zip(ls, lf):
        fs = (k / i) * ((x / i)**(k - 1.)) * np.exp(-(x / i)**k)
        plt.plot(x, fs, linewidth=2, label='Mean/nominal speed: %0.2f' %i)
        ff = (k / j) * ((x / j)**(k - 1.)) * np.exp(-(x / j)**k)
        plt.plot(x, ff, linewidth=2, label='Mean/nominal force: %0.2f' %j)

    plt.ylabel('Probability density function (pdf) of wind speed')
    plt.xlabel('Normalised wind speed')
    plt.grid(True)
    plt.legend(loc=0)
    plt.savefig('pdf.svg')
    plt.show()
    pass

if __name__ == '__main__':
    main()