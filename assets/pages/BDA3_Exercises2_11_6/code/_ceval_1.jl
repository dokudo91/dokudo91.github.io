# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
plot(NegativeBinomial(5,1//6),yrotation=90,label="NegativeBinomial(5,1//6)")
savefig(joinpath(@OUTPUT, "NegativeBinomial.svg"))
nothing
