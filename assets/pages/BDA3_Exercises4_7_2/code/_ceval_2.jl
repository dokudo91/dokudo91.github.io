# This file was generated, do not modify it. # hide
using Distributions, LinearAlgebra
expx = exp.(α .+ β .* x)
expx12 = (1 .+ expx) .^2
dlogpdα = sum(n .* expx ./ expx12)
dlogpdαβ = sum(n .* x .* expx ./ expx12)
dlogpdβ = sum(n .* x .^2 .* expx ./ expx12)
Iαβ = [dlogpdα dlogpdαβ; dlogpdαβ dlogpdβ]
normalappro = MvNormal([α, β], inv(Iαβ))
contour(-5:0.1:5,-10:0.1:30,(α,β)->pdf(normalappro, [α, β]))
savefig(joinpath(@OUTPUT, "normalappro.svg"))
nothing
