# This file was generated, do not modify it. # hide
nonnormalized_posterior_noncon_pdf(x) = pdf(Binomial(980,x),437) * noncon_prior_pdf(x)
constant = sum(nonnormalized_posterior_noncon_pdf(x)*0.001 for x in 0:0.001:1)
normalized_posterior_noncon_pdf(x) = nonnormalized_posterior_noncon_pdf(x) / constant
plot(0.3:0.001:0.6, normalized_posterior_noncon_pdf,yrotation=90,label="nonconjugate")
plot!(0.3:0.001:0.6, posterior_dist,label="conjugate")
savefig(joinpath(@OUTPUT, "normalized_posterior_noncon_pdf.svg"))
nothing
