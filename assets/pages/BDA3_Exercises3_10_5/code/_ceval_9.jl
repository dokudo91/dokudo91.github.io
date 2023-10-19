# This file was generated, do not modify it. # hide
function z(normal_dists, yi)
    n=length(normal_dists)
    lowers = cdf.(normal_dists, yi-0.5)
    uppers = cdf.(normal_dists, yi+0.5)
    quantile.(normal_dists, lowers .+ rand(n) .* (uppers .- lowers))
end
z([Normal(μσ_sample...)], 10)
