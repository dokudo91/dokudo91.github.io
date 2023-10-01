# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
prior_dist=Beta(α,β)
plot(prior_dist,yrotation=90,label="Beta(α=1,β=2/3)")
savefig(joinpath(@OUTPUT, "prior.svg"))
nothing
