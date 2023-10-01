# This file was generated, do not modify it. # hide
plot(posterior_dist,yrotation=90,label="Beta(1+y,2/3+n-y)",xlim=(0.5,0.8))
plot!(Beta(1+y,10+n-y),label="Beta(1+y,10+n-y)")
plot!(Beta(y,n-y),label="Beta(y,n-y)")
savefig(joinpath(@OUTPUT, "sensitivity.svg"))
nothing
