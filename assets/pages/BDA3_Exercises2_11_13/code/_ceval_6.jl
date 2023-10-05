# This file was generated, do not modify it. # hide
using Printf
b_posterior_dist=Gamma(1//2+sum(df.FatalAccidents),1/sum(passenger_miles))
plot(b_posterior_dist,yrotation=90,label="Gamma($(shape(b_posterior_dist)), $(@sprintf("%.2e", scale(b_posterior_dist))))")
savefig(joinpath(@OUTPUT, "b_posterior_dist.svg"))
nothing
