# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
plot(Exponential(2), label="PDF")
savefig(joinpath(@OUTPUT, "exponential.svg"))