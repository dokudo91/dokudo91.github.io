# This file was generated, do not modify it. # hide
using QuadGK
unnormalized_posterior_pdf(θ)=prior_pdf(θ)*likelihood_pdf(θ)
marginal_pdf,_=quadgk(unnormalized_posterior_pdf,0,100)
posterior_pdf(θ)=unnormalized_posterior_pdf(θ)/marginal_pdf
plot(0:0.1:100,posterior_pdf,yrotation=90,label="posterior")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
