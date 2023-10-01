# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
μₙ(n)=(1//40^2*180+n//20^2*150)//(1//40^2+n//20^2)
plot(1:50,μₙ,yrotation=90,label="μₙ(n)")
savefig(joinpath(@OUTPUT, "mean.svg"))
nothing
