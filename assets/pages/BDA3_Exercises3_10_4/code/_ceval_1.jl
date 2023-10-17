# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
posterior_p0_dist=Beta(39,674-39)
posterior_p1_dist=Beta(22,680-22)
plot(posterior_p0_dist, label="control", yrotation=90)
plot!(posterior_p1_dist, label="treatment")
savefig(joinpath(@OUTPUT, "posterior_p.svg"))
nothing
