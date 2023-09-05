# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
plot(Uniform(1, 3), label="PDF")
savefig(joinpath(@OUTPUT, "uniform.svg"))