# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
meany=1000*1/6
stdy=sqrt(1000*1/6*(1-1/6))
nay=Normal(meany,stdy)
plot(nay,label="Normal",yrotation=90)
plot!(Binomial(1000,1/6),label="Binomial(1000,1/6)",xlims=(100,250))
savefig(joinpath(@OUTPUT, "Binomial.svg"))
nothing
