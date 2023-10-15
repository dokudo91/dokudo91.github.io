using Distributions, StatsPlots
const θ_true = [0.3, 0.4, 0.2, 0.1]
# y=rand(Multinomial(100, θ_true))
const y=[28,46,16,10]
prior_θ_dist = Dirichlet(4,1)
unnormalized_posterior_θ(θ, y) = pdf(prior_θ_dist, θ) * pdf(Multinomial(100, θ), y)
using HCubature
function marginal(y)
    result,_=hcubature(
        function (θ)
            sum(θ) > 1 && return 0
            return unnormalized_posterior_θ([θ; 1-sum(θ)], y)
        end, zeros(3), ones(3))
    result
end
posterior_θ(θ, y) = unnormalized_posterior_θ(θ, y) / marginal(y)
marginal_y=marginal(y)
posterior_θ(θ) = unnormalized_posterior_θ(θ, y) / marginal_y

function generate_probabilities(probability_function,dimension,n)
    samples=Vector{Float64}[]
    for _ in 1:n
        while true
            θ = rand(Float64,dimension-1)
            sum(θ)>1 && continue
            push!(θ,1-sum(θ))
            acceptance_prob=probability_function(θ)
            if rand() < acceptance_prob
                push!(samples,θ)
                break
            end
        end
    end
    return samples
end
probabilities=generate_probabilities(posterior_θ,4,1000)
mprobabilities=hcat(probabilities...)
scatter(mprobabilities[1,:],mprobabilities[2,:])
fit(MvNormal,mprobabilities[1:2,:])