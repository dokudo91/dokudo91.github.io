using Distributions, StatsPlots
meany=1000*1/6
stdy=sqrt(1000*1/6*(1-1/6))
nay=Normal(meany,stdy)
y=Binomial(1000,1/6)
plot(nay)
plot!(y,xlims=(100,250))

using DataFrames

q = [0.05,0.25,0.5,0.75,0.95]
nayq = quantile(nay, q)
yq = quantile(Binomial(1000,1/6), q)
"""$(join(q,","))
$(join(nayq,","))
$(join(yq,","))"""