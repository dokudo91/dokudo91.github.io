# This file was generated, do not modify it. # hide
prior4_dist = Beta(0.485*200,(1-0.485)*200)
posterior4_dist = Beta(0.485*200+437,(1-0.485)*200+543)
plot(prior4_dist,yrotation=90,label="prior")
plot!(posterior4_dist,label="posterior")
savefig(joinpath(@OUTPUT, "posterior4_dist.svg"))
nothing
