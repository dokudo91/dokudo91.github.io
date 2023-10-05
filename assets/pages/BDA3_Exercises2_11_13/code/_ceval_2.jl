# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
n=length(df.FatalAccidents)
fa_rate_posterior_dist=Gamma(1//2+sum(df.FatalAccidents),1//n)
plot(fa_rate_posterior_dist,yrotation=90,label="θ_posterior")
savefig(joinpath(@OUTPUT, "fa_rate_posterior.svg"))
nothing
