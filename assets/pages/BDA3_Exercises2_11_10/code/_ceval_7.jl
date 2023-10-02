# This file was generated, do not modify it. # hide
noninfo_prior(N)=1/1000/N
plot(1:1000,N->posterior(N,203,noninfo_prior),label="noninfo_posterior",yrotation=90)
savefig(joinpath(@OUTPUT, "noninfo_posterior.svg"))
nothing
