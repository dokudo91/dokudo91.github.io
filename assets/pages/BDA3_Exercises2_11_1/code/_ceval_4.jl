# This file was generated, do not modify it. # hide
posterior(θ)=likelihood_function(θ)*pdf(prior_dist,θ)/sum(marginal.(0:2))
plot(posterior,label="posterior(θ)",yrotation=90)
plot!(prior_dist,label="prior(θ)")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
