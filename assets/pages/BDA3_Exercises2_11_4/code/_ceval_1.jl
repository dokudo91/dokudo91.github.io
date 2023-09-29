# This file was generated, do not modify it. # hide
using Distributions, StatsPlots
conditional_y(θ)=Normal(1000*θ,sqrt(1000*θ*(1-θ)))
plot(conditional_y(1//12),label="θ=1/12",yrotation=90)
plot!(conditional_y(1//6),label="θ=1/6")
plot!(conditional_y(1//4),label="θ=1/4")
savefig(joinpath(@OUTPUT, "conditional_y.svg"))
nothing
