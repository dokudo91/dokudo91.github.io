# This file was generated, do not modify it. # hide
phi = (1 .- th) ./ th
histogram(phi,yrotation=90,label="1-θ/θ")
savefig(joinpath(@OUTPUT, "phi.svg"))
nothing
