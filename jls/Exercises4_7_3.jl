using Distributions, StatsPlots

logit(x)=log(x/(1-x))
logistic(x)=1/(1+exp(-x))

x=[-0.86,-0.3,-0.05,0.73]
n=5
y=[0,1,3,5]

function likelihood_yi(y, θL, θβ, n, x)
    θ = logistic(-θL * θβ + θβ * x)
    θ^y * (1-θ)^(n-y)
end
function loglikelihood_yi(y, θL, θβ, n, x)
    θ = logistic(-θL * θβ + θβ * x)
    y*log(θ) + (n-y)*log(1-θ)
end
likelihood_y(y, θL, θβ, n, x)=prod(likelihood_yi.(y, θL, θβ, n, x))
loglikelihood_y(y, θL, θβ, n, x)=sum(loglikelihood_yi.(y, θL, θβ, n, x))

posteriorθLθβ(θL, θβ, y, n, x) = abs(θβ) * likelihood_y(y, θL, θβ, n, x)

posteriorθLθβ.((-5:0.01:5)', 0.001:0.005:20, y|>Ref, n, x|>Ref)

posteriorθL = sum(posteriorθLθβ.((-1:0.01:1)', 0.01:0.01:10, y|>Ref, n, x|>Ref), dims=1) |> vec
histogram(wsample(-1:0.01:1, posteriorθL, 10000))
plot(-1:0.01:1, posteriorθL)

θLmode = vec(-1:0.01:1)[argmax(posteriorθL)]

posteriorθL_pdf(θL, y, n, x)=sum(posteriorθLθβ.(θL, -30:0.0001:30, y|>Ref, n, x|>Ref))
using QuadGK
function posteriorθL_pdf(θL, y, n, x)
    result,_=quadgk(θ->posteriorθLθβ(θL, θ, y, n, x), -Inf, Inf)
    result
end

using ForwardDiff
I(θL, y, n, x) = -ForwardDiff.derivative(θ2 -> ForwardDiff.derivative(θ1 -> posteriorθL_pdf(θ1, y, n, x), θ2), θL)
I(θL, y, n, x) = -ForwardDiff.hessian(θ -> posteriorθL_pdf(θ[1], y, n, x), [θL]) |> first
I(θLmode, y, n, x)^-0.5
posteriorθL_appro_dist = Normal(θLmode, I(θLmode, y, n, x)^-0.5)
histogram(rand(posteriorθL_appro_dist, 10000))