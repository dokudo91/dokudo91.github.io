# This file was generated, do not modify it. # hide
posterior2_predicts = [predict(posterior_dists[2]) for _ in 1:5000]
yBush2=getindex.(posterior2_predicts, 1)
yDukakis2=getindex.(posterior2_predicts, 2)
stephist(yBush2, label="post-debate Bush", xlim=(220,380), yrotation=90)
stephist!(yDukakis2, label="post-debate Dukakis")
savefig(joinpath(@OUTPUT, "posterior2.svg"))
nothing
