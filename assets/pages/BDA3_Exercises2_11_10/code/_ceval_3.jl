# This file was generated, do not modify it. # hide
marginal(y,summax,prior)=sum(prior(N)*likelihood(y,N) for N in 1:summax)
plot(1:2000,summax->marginal(203,summax,x->pdf(gprior_dist,x)),label="marginal",yrotation=90)
savefig(joinpath(@OUTPUT, "marginal.svg"))
nothing
