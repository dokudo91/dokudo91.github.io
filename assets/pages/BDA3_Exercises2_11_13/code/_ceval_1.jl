# This file was generated, do not modify it. # hide
using DataFrames, CSV
io=IOBuffer("""
Year FatalAccidents PassengerDeaths DeathRate
1976 24 734 0.19
1977 25 516 0.12
1978 31 754 0.15
1979 31 877 0.16
1980 22 814 0.14
1981 21 362 0.06
1982 26 764 0.13
1983 20 809 0.13
1984 16 223 0.03
1985 22 1066 0.15
""")
df = CSV.File(io, delim = ' ', header=true) |> DataFrame
