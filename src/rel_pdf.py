#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
"""
Load and resistance probability density and safety margins as per
ISO 19902:2007
rel_pdf.py -- 2018 ckunte
"""
from scipy.stats import norm
import numpy as np
import matplotlib.pyplot as plt

# Function for plotting probability density by region


def pd(exp, reg, Em, Ve, Rm, Vr):
    mu_e = np.log(Em / np.sqrt(1 + Ve ** 2))  # mean
    mu_r = np.log(Rm / np.sqrt(1 + Vr ** 2))  # mean
    sigma_e = np.sqrt(np.log(1 + Ve ** 2))
    sigma_r = np.sqrt(np.log(1 + Vr ** 2))
    s_e = np.random.lognormal(mu_e, sigma_e, 1000)
    s_r = np.random.lognormal(mu_r, sigma_r, 1000)
    count_e, bins_e, ignored_e = plt.hist(
        s_e, 100, normed=True, align="mid", alpha=0.09, color="r"
    )
    count_r, bins_r, ignored_r = plt.hist(
        s_r, 100, normed=True, align="mid", alpha=0.09, color="g"
    )
    x_e = np.linspace(min(bins_e), max(bins_e), 10000)
    x_r = np.linspace(min(bins_r), max(bins_r), 10000)
    pdf_E = np.exp(
        -((np.log(x_e) - mu_e) ** 2) / (2 * sigma_e ** 2)
    ) / (x_e * sigma_e * np.sqrt(2 * np.pi))
    pdf_R = np.exp(
        -((np.log(x_r) - mu_r) ** 2) / (2 * sigma_r ** 2)
    ) / (x_r * sigma_r * np.sqrt(2 * np.pi))
    plt.plot(x_e, pdf_E, linewidth=1, color="r")
    plt.plot(x_r, pdf_R, linewidth=1, color="g")
    plt.xlim(0.25, 2.75)
    plt.ylim(0, 5.0)
    plt.title("%s - %s" % (reg, exp))
    plt.xlabel(
        "Load or resistance as times the nominal load, $x, E_{mean}(%.2f); x, R_{mean}(%.2f)$"
        % (Em, Rm)
    )
    plt.ylabel("Probability density")
    plt.axvline(x=Em, color="r", linestyle=":")
    plt.axvline(x=Rm, color="g", linestyle=":")
    plt.rcParams["grid.linestyle"] = ":"
    plt.rcParams["grid.linewidth"] = 0.5
    plt.grid(True)
    plt.savefig("pd_%s_%s.png" % (reg, exp))
    plt.close()
    pass


"""
Legend:

 exp -- Exposure level (L1 or L2)
 reg -- region
  Em -- Mean load for a reference return period
  Ve -- Load covariance
  Rm -- Mean reserve strength ratio
  Vr -- Resistance covariance

where, for CNS and SNS, NNS, GOM, AUS:

  Ve = map(sqrt(x^2 + 0.08^2), COV) => [0.2266, 0.2768, 0.3298, 0.3396]
 COV = [0.212, 0.265, 0.32, 0.33] 
  Rm = [1.73, 1.92, 1.85, 2.18] for L1 (target Pf = 3E-5/y)
  Rm = [1.40, 1.49, 1.60, 1.60] for L2 (target Pf = 5E-4/y)

"""


def main():
    # pd(exp, reg, Em, Ve, Rm, Vr)
    pd("L1", "GoM", 0.79, 0.3298, 1.85, 0.05)
    pd("L2", "GoM", 0.79, 0.3298, 1.60, 0.05)
    pd("L1", "NNS", 0.81, 0.2768, 1.92, 0.05)
    pd("L2", "NNS", 0.81, 0.2768, 1.49, 0.05)
    pd("L1", "CNS", 0.84, 0.2266, 1.73, 0.05)
    pd("L2", "CNS", 0.84, 0.2266, 1.40, 0.05)
    pd("L1", "AUS", 0.78, 0.3396, 2.18, 0.05)
    pd("L2", "AUS", 0.78, 0.3396, 1.60, 0.05)
    pass


if __name__ == "__main__":
    main()
