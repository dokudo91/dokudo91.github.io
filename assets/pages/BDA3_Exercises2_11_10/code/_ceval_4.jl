# This file was generated, do not modify it. # hide
posterior(N,y,prior)=prior(N)*likelihood(y,N)/marginal(y,1000,prior)
plot(1:1000,N->posterior(N,203,x->pdf(gprior_dist,x)),label="posterior",yrotation=90)
plot!(1:1000,N->likelihood(203,N),label="likelihood")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
