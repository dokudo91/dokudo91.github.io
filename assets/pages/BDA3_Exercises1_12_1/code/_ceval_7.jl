# This file was generated, do not modify it. # hide
plot(y->posterior_θ1_σ(0.5,y),label="Pr(θ|y): σ=0.5", xlims=(-25,25), yrotation=90)
plot!(y->posterior_θ1_σ(1,y),label="Pr(θ|y): σ=1")
plot!(y->posterior_θ1_σ(2,y),label="Pr(θ|y): σ=2")
plot!(y->posterior_θ1_σ(3,y),label="Pr(θ|y): σ=3")
savefig(joinpath(@OUTPUT, "posterior_θ1_σ.svg"))
nothing
