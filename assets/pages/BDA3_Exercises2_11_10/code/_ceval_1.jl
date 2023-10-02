# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
gprior_dist=Geometric(1/100)
plot(gprior_dist,label="prior",yrotation=90)
savefig(joinpath(@OUTPUT, "gprior.svg"))
nothing
