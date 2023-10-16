# This file was generated, do not modify it. # hide
dif = rand(α2_dist, 5000) .- rand(α1_dist, 5000)
histogram(dif, label="α2 - α1", yrotation=90)
savefig(joinpath(@OUTPUT, "dif.svg"))
nothing
