# This file was generated, do not modify it. # hide
d_posterior_dist=Gamma(1//2+sum(df.PassengerDeaths),1/sum(passenger_miles))
plot(d_posterior_dist,yrotation=90,label="d_posterior_dist")
savefig(joinpath(@OUTPUT, "d_posterior_dist.svg"))
nothing
