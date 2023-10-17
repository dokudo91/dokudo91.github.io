# This file was generated, do not modify it. # hide
using Random
Random.seed!(1)
posterior_p0 = rand(posterior_p0_dist,5000)
posterior_p1 = rand(posterior_p1_dist,5000)
odds_ratio = (posterior_p1 ./ (1 .- posterior_p1)) ./ (posterior_p0 ./ (1 .- posterior_p0))
histogram(odds_ratio, label="odds ratio", yrotation=90)
savefig(joinpath(@OUTPUT, "odds_ratio.svg"))
quantile(odds_ratio, [.025,.975])
