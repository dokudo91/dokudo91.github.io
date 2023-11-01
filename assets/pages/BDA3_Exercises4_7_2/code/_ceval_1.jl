# This file was generated, do not modify it. # hide
using StatsPlots
x=[-0.86,-0.3,-0.05,0.73]
n=5
y=[0,1,3,5]
logistic(x)=1/(1+exp(-x))
function likelihood_yi(y,α,β,n,x)
    θ=logistic(α+β*x)
    θ^y * (1-θ)^(n-y)
end
likelihood_y(y,α,β,n,x)=prod(likelihood_yi.(y,α,β,n,x))
contour(-5:0.1:5,-10:0.1:30,(α,β)->likelihood_y(y,α,β,n,x), yrotation=90)
savefig(joinpath(@OUTPUT, "likelihood_y.svg"))
max_index = argmax(likelihood_y.(y|>Ref,(0:0.01:2)',5:0.01:10,n,x|>Ref))
matrix_αβ = tuple.((0:0.01:2)',5:0.01:10)
α, β = matrix_αβ[max_index]
