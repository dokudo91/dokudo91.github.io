# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
control_dist = 1.013 + TDist(32-1)*0.24/sqrt(32)
exposed_dist = 1.173 + TDist(36-1)*0.2/sqrt(36)
plot(control_dist, label="control", yrotation=90)
plot!(exposed_dist, label="exposed")
savefig(joinpath(@OUTPUT, "TDist.svg"))
nothing
