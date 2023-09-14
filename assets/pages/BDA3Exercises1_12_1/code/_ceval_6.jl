# This file was generated, do not modify it. # hide
posterior_θ1(y)=posterior_θ1_σ(2,y)
plot(posterior_θ1,label="Pr(θ=1|y=1)", xlims=(-25,25), yrotation=90)
savefig(joinpath(@OUTPUT, "posterior_θ1.svg"))
nothing
