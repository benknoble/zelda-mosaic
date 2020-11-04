#! /usr/bin/env python3

import sys

import pandas as pd


def csv(*args, **kwargs):
    return pd.read_csv(*args, **kwargs)


def predicate_name(column_names):
    return "_".join(map(str.lower, filter(str.isalnum, column_names)))


def predicate_ify(name, values):
    args = ", ".join(map(lambda v: f"'{v}'", values))
    return f"{name}({args})"


def csv_to_prolog(df):
    name = predicate_name(df.columns)
    as_predicates = df.apply(lambda row: predicate_ify(name, row), axis=1)
    return ",\n".join(as_predicates)


def main(filename):
    df = csv(filename)
    print(csv_to_prolog(df))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} <filename>")
        sys.exit(1)
    else:
        main(sys.argv[1])
