using Distributions, StatsPlots

logit(x)=log(x/(1-x))
logistic(x)=1/(1+exp(-x))

x=[-0.86,-0.3,-0.05,0.73]
n=5
y=[0,1,3,5]

function likelihood_yi(y,α,β,n,x)
    θ=logistic(α+β*x)
    θ^y * (1-θ)^(n-y)
end
likelihood_y(y,α,β,n,x)=prod(likelihood_yi.(y,α,β,n,x))
#contour(-5:0.1:5,0:0.1:30,(α,β)->likelihood_y(y,α,β,n,x))

max_index = argmax(likelihood_y.(y|>Ref,(0:0.01:2)',5:0.01:10,n,x|>Ref))
matrix_αβ = tuple.((0:0.01:2)',5:0.01:10)
α, β = matrix_αβ[max_index]

expx = exp.(α .+ β .* x)
expx12 = (1 .+ expx) .^2
dlogpdα = sum(n .* expx ./ expx12)
dlogpdαβ = sum(n .* x .* expx ./ expx12)
dlogpdβ = sum(n .* x .^2 .* expx ./ expx12)

Iαβ = [dlogpdα dlogpdαβ; dlogpdαβ dlogpdβ]
using LinearAlgebra
inv(Iαβ)
normalappro = MvNormal([α, β], inv(Iαβ))
pdf(normalappro, [1,1])
contour(-5:0.1:5,-10:0.1:30,(α,β)->pdf(normalappro, [α, β]))