#! /usr/bin/env python3

import sys
import shlex

import pandas as pd


def csv(*args, **kwargs):
    return pd.read_csv(*args, **kwargs)


def quote(values):
    return " ".join(map(shlex.quote, values))


def csv_to_shell(df):
    return "\n".join(df.apply(quote, axis=1))


def main(filename):
    df = csv(filename)
    print(csv_to_shell(df))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} <filename>")
        sys.exit(1)
    else:
        main(sys.argv[1])
