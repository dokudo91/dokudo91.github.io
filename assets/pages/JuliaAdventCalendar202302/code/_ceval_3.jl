# This file was generated, do not modify it. # hide
uniform = Uniform(2,5)
plot(uniform, yrotation=90, label="uniform", ylim=(0,0.5))
savefig(joinpath(@OUTPUT, "uniform.svg"))
nothing
