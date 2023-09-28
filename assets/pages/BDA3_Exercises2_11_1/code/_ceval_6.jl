# This file was generated, do not modify it. # hide
histogram(chain[:θ],normalize=true,label="simulation",xlims=(0,1))
plot!(posterior,label="posterior(θ)")
savefig(joinpath(@OUTPUT, "simulation.svg"))
nothing
