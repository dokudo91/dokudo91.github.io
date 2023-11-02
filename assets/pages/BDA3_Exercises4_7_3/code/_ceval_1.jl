# This file was generated, do not modify it. # hide
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
likelihood_y(y, θL, θβ, n, x)=prod(likelihood_yi.(y, θL, θβ, n, x))

posteriorθLθβ(θL, θβ, y, n, x) = abs(θβ) * likelihood_y(y, θL, θβ, n, x)
posteriorθL = sum(posteriorθLθβ.((-1:0.01:1)', 0:0.01:10, y|>Ref, n, x|>Ref), dims=1) |> vec
histogram(wsample(-1:0.01:1, posteriorθL, 10000), label="posterior θL", yrotation=90)
savefig(joinpath(@OUTPUT, "posteriorθL.svg"))
nothing
