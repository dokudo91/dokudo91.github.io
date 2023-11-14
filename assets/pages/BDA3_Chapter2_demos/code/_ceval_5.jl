# This file was generated, do not modify it. # hide
th = rand(posterior_dist,10000)
histogram(th,yrotation=90,label="Beta(1+437,1+543)")
savefig(joinpath(@OUTPUT, "histogram.svg"))
nothing
