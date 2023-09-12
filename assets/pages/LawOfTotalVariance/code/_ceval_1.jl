# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
μm = 170
σm = 10
μf = 160
σf = 5

dist_male = Normal(μm, σm)
dist_female = Normal(μf, σf)

Y = MixtureModel([dist_male, dist_female], [0.6, 0.4])
plot(Y, label=["male PDF" "female PDF"], yrotation=90)
plot!(x->pdf(Y,x), label="Mixture PDF")
savefig(joinpath(@OUTPUT, "LawOfTotalVariance.svg"))
nothing
