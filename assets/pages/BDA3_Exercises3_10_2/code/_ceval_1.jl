# This file was generated, do not modify it. # hide
using DataFrames, CSV
io=IOBuffer("""
Bush Dukakis other
294 307 38
288 332 19
""")
df = CSV.File(io, delim = ' ', header=true) |> DataFrame
