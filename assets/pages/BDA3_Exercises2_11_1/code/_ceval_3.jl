# This file was generated, do not modify it. # hide
using QuadGK
function marginal(y)
    result, error = quadgk(θ->likelihood_function(y,θ)*pdf(prior_dist,θ), 0, 1)
    result
end
scatter(0:1:10,y->marginal(y), label="p(y)", yrotation=90)
savefig(joinpath(@OUTPUT, "marginal.svg"))
nothing
