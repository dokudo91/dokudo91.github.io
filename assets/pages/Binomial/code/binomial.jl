# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
plot(Binomial(10, 0.6), xlabel="number of trials", ylabel="probability", label=nothing, xticks=0:1:10)
savefig(joinpath(@OUTPUT, "binomial_10_06.svg"))