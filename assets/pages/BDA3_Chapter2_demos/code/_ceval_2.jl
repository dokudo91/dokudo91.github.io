# This file was generated, do not modify it. # hide
prior2_dist = Beta(0.485*2,(1-0.485)*2)
posterior2_dist = Beta(0.485*2+437,(1-0.485)*2+543)
plot(prior2_dist,yrotation=90,label="Beta(0.485*2,(1-0.485)*2)")
plot!(posterior2_dist,label="Beta(0.485*2+437,(1-0.485)*2+543)")
savefig(joinpath(@OUTPUT, "posterior2_dist.svg"))
nothing
