# This file was generated, do not modify it. # hide
n=length(df.PassengerDeaths)
c_posterior_dist=Gamma(1//2+sum(df.PassengerDeaths),1//n)
plot(c_posterior_dist,yrotation=90,label="c_posterior_dist",xlim=(500,1000))
savefig(joinpath(@OUTPUT, "c_posterior_dist.svg"))
nothing
