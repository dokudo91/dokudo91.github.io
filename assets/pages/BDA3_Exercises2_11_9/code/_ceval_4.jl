# This file was generated, do not modify it. # hide
n=1000
y=1000*0.65
posterior_dist=Beta(α+y,β+n-y)
plot(prior_dist,yrotation=90,label="prior")
plot!(posterior_dist,label="posterior")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
