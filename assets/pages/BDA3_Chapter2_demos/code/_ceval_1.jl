# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
prior_dist = Beta(1,1)
posterior_dist = Beta(1+437,1+543)
plot(prior_dist,yrotation=90,label="Beta(1,1)")
plot!(posterior_dist,label="Beta(438,544)")
savefig(joinpath(@OUTPUT, "posterior_dist.svg"))
nothing
