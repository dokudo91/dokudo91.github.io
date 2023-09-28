using Distributions
using StatsPlots

prior_dist=Beta(4,4)
likelihood_dist(θ)=Binomial(10,θ)
likelihood_function(y,θ)=pdf(likelihood_dist(θ),y)
likelihood_function(θ)=likelihood_function.([0,1,2],θ)|>sum

using QuadGK
function marginal(y)
    result, error = quadgk(θ->likelihood_function(y,θ)*pdf(prior_dist,θ), 0, 1)
    result
end
posterior(θ,y)=likelihood_function(y,θ)*pdf(prior_dist,θ)/marginal(y)
posterior(θ)=likelihood_function(θ)*pdf(prior_dist,θ)/sum(marginal.(0:2))
#plot(posterior,label="posterior(θ)")

using Turing
@model function coin_flip_model(y)
    θ ~ Beta(4, 4)
    @. y ~ Binomial(10, θ)
end
model = coin_flip_model(0:2)
chain = sample(model, NUTS(), 1000)
histogram(chain[:θ],normalize=true)