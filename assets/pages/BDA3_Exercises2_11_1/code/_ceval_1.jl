# This file was generated, do not modify it. # hide
using Distributions
using StatsPlots

prior_dist=Beta(4,4)
plot(prior_dist,label="Beta(4,4)",yrotation=90)
plot!(Beta(5,5),label="Beta(5,5)")
savefig(joinpath(@OUTPUT, "prior_dist.svg"))
nothing
