# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
plot(Uniform(1, 3), xlims=(0,4), ylims=(0,1), label="PDF")
savefig(joinpath(@OUTPUT, "uniform.svg"))