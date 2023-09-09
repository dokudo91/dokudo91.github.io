# This file was generated, do not modify it. # hide
using CSV, DataFrames, StatsPlots
df = CSV.File("_assets/datasets/football.csv", delim = ' ', ignorerepeated = true, header=true) |> DataFrame
first(df, 5)
