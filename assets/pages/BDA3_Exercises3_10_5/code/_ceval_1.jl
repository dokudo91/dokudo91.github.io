# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
y=[10, 10, 12, 11, 9]
posterior_variance_a_dist = InverseGamma((length(y)-1)//2, 1//2) * std(y)
plot(posterior_variance_a_dist, label="posterior variance", yrotation=90, xlim=(0,4))
savefig(joinpath(@OUTPUT, "posterior_variance_a_dist.svg"))
nothing
