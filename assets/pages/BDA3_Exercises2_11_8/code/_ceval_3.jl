# This file was generated, do not modify it. # hide
posterior_dist(n)=Normal(μₙ(n),sqrt(τₙ²(n)))
plot(Normal(180,40),yrotation=90,label="prior:N(180,40^2)",xlim=(100,250))
plot!(posterior_dist(3),label="N(μₙ(3),τₙ²(3))")
plot!(posterior_dist(20),label="N(μₙ(20),τₙ²(20))")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
