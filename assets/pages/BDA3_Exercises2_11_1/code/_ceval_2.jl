# This file was generated, do not modify it. # hide
likelihood_dist(θ)=Binomial(10,θ)
likelihood_function(y,θ)=pdf(likelihood_dist(θ),y)
likelihood_function(θ)=likelihood_function.(0:2,θ)|>sum
likelihood_function.([0.1,0.5])
