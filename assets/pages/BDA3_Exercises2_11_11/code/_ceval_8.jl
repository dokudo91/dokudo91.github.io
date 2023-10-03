# This file was generated, do not modify it. # hide
using Random
Random.seed!(1)
ysamples=rand(posterior_y_dist,1000)
histogram(ysamples,yrotation=90,label="posterior_y")
savefig(joinpath(@OUTPUT, "posterior_y.svg"))
extrema(ysamples)
