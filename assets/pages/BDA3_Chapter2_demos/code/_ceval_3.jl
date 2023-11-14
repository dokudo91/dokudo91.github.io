# This file was generated, do not modify it. # hide
prior3_dist = Beta(0.485*20,(1-0.485)*20)
posterior3_dist = Beta(0.485*20+437,(1-0.485)*20+543)
plot(prior3_dist,yrotation=90,label="prior")
plot!(posterior3_dist,label="posterior")
savefig(joinpath(@OUTPUT, "posterior3_dist.svg"))
nothing
