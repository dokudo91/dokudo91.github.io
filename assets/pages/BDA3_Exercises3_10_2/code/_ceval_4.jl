# This file was generated, do not modify it. # hide
using StatsPlots
posterior1_predicts = [predict(posterior_dists[1]) for _ in 1:5000]
yBush1=getindex.(posterior1_predicts, 1)
yDukakis1=getindex.(posterior1_predicts, 2)
stephist(yBush1, label="pre-debate Bush", xlim=(220,380), yrotation=90)
stephist!(yDukakis1, label="pre-debate Dukakis")
savefig(joinpath(@OUTPUT, "posterior1.svg"))
nothing
