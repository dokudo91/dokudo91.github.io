# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
plot(-20:0.1:20,x->pdf(Cauchy(),x),label="Cauchy",yrotation=90)
plot!(Normal(),label="Normal")
savefig(joinpath(@OUTPUT, "Cauchy.svg"))
mean(Cauchy()), var(Cauchy())
