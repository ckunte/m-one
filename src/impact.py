#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Time versus velocity and depth of a dropped pipe through seawater
impact.py -- 2020 ckunte
"""

import numpy as np
import matplotlib.pyplot as plt

# Legend:
#   v_t -- terminal velocity (m/s)
#   t -- time (s)
g = 9.81  # acceleration due to gravity (m/s^2)


def tvelo(v_t, t):
    # v_t -- terminal velocity
    # t -- time
    v = v_t * np.tanh(g * t / v_t)
    plt.plot(t, v, linewidth=2)
    plt.xlabel("Time, t (s)")
    plt.ylabel("Velocity, v (m/s)")
    plt.grid(True)
    plt.savefig("t_v.png")
    plt.close()
    pass


def tdepth(y0, v_t, t):
    y = y0 - (v_t ** 2 / g) * np.log(np.cosh(g * t / v_t))
    plt.plot(t, y, linewidth=2)
    plt.xlabel("Time, t (s)")
    plt.ylabel("Depth, d (m)")
    plt.axhline(y=-168.5, color="r", linestyle=":")
    plt.grid(True)
    plt.savefig("t_d.png")
    plt.close()
    pass


def main():
    tvelo(13.654, np.arange(0.1, 10.0, 0.01))
    tdepth(0.0, 13.654, np.arange(0.1, 14.0, 0.01))
    pass


if __name__ == "__main__":
    main()