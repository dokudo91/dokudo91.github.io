# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
pu=MvNormal([0, 0],[1 0; 0 1])
contour(-0.5:0.01:0.5, -0.5:0.01:0.5, (x, y) -> pdf(pu, [x, y]), size=(500, 400))
savefig(joinpath(@OUTPUT, "pu.svg"))
pdf(pu, [0, 0])
