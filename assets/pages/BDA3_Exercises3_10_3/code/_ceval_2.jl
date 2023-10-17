# This file was generated, do not modify it. # hide
using Random
Random.seed!(1)
ycontrol=rand(control_dist,5000)
yexposed=rand(exposed_dist,5000)
dif = yexposed .- ycontrol
histogram(dif, label="µt - µc", yrotation=90)
savefig(joinpath(@OUTPUT, "dif.svg"))
quantile(dif,[.025,.975])
