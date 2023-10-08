# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
plot(Chisq(10),yrotation=90,label="Chisq(10)")
savefig(joinpath(@OUTPUT, "Chisq10.svg"))
nothing
