# This file was generated, do not modify it. # hide
using Plots
Pr(n)=Pr(n, 0.4)
plot(1:10:500, Pr, yrotation=90, label=nothing)
savefig(joinpath(@OUTPUT, "WLLN.svg"))
nothing
