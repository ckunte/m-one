#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
stormsafety.py -- Probability of encountering a design wave during
piling. 2019 ckunte
"""
import numpy as np
import matplotlib.pyplot as plt


def plot_encounter_probability(L, T, lbl):
    for i, j in zip(L, lbl):
        p = (1 - np.exp(-i / T)) * 100  # in %
        plt.semilogx(T, p, label=j + " piling")
        pass
    plt.xlabel("Return period, T (years)")
    plt.ylabel("Probability of encountering design wave, p (%)")
    plt.legend(loc=0)
    plt.savefig("stormsafety.svg")
    plt.close()
    pass


if __name__ == "__main__":
    lbl = ["10 day", "1 month", "2 month", "3 month", "4 month", 
        "6 month"]
    L = [0.027, 0.083, 0.167, 0.250, 0.333, 0.500] # in years
    T = np.arange(1.0, 50.0, 0.1)
    plot_encounter_probability(L, T, lbl)
    