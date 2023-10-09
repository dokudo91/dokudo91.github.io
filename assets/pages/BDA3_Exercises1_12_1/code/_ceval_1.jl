# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
y1_dist(σ) = Normal(1,σ)
y2_dist(σ) = Normal(2,σ)
plot(y1_dist(2),label="Pr(y|θ=1)",yrotation=90)
plot!(y2_dist(2),label="Pr(y|θ=2)")
savefig(joinpath(@OUTPUT, "y1y2.svg"))
nothing
