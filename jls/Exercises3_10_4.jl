using Distributions, StatsPlots

posterior_p0_dist=Beta(39,674-39)
posterior_p1_dist=Beta(22,680-22)
plot(posterior_p0_dist)
plot!(posterior_p1_dist)

posterior_p0 = rand(posterior_p0_dist,5000)
posterior_p1 = rand(posterior_p1_dist,5000)
odds_ratio = (posterior_p1 ./ (1 .- posterior_p1)) ./ (posterior_p0 ./ (1 .- posterior_p0))
histogram(odds_ratio)

plot(FDist(39,22))