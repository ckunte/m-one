#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Query master document register for info
mdr.py 2022 ckunte

Examples:

    # filter for all reports
    python3 mdr.py | grep -i "report"

    # filter reports expected in, say, Apr 2022 (when date is in yyyy-mm-dd format)
    python3 mdr.py | grep "2022-04-" | grep -i "report"

    # get a list of expected deliverables for, say, Apr and May 2022
    python3 mdr.py | grep -E "2022\-0[4-5]-"

    # get a list of expected deliverables for, say, CG, CS, CX tags
    python3 mdr.py | grep -E "\-C[G|S|X]-"

    # get a list of expected deliverables for, say, CG, CS, CX, and NZ tags
    python3 mdr.py | grep -E "\-C[G|S|X]-|\-NZ-"

    # get the above for say Q3 and Q4 of Year 2022
    python3 mdr.py | grep -E "\-C[G|S|X]-|\-NZ-" | grep -E "2022\-0[6-9]|1[0-2]-"

"""
import pandas as pd


def main():
    # Read data
    df = pd.read_csv("./mdr.csv")

    # Limit "TITLE" column width
    df["TITLE"] = df["TITLE"].str[:30]

    # Sort data by a specific column
    df.sort_values(by="IFR FORECAST", inplace=True)

    # Select fewer columns to export
    df_sel = df[["TITLE", "NUMBER", "CAT", "IFR FORECAST"]]

    # Export data of selected columns to a csv file
    df_sel.to_csv("./mdr-ifr_fc.csv")

    # Print filtered data to screen
    print(df_sel.to_string())
    pass


if __name__ == "__main__":
    main()