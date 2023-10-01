# This file was generated, do not modify it. # hide
μ₁(n)=(1//40^2*180+n//20^2*150)//(1//40^2+n//20^2)
τ₁²(n)=1//(1//40^2+n//20^2)+20^2
posterior_predictive_dist(n)=Normal(μ₁(n),sqrt(τ₁²(n)))
plot(Normal(180,40),yrotation=90,label="prior(θ)",xlim=(100,250))
plot!(posterior_dist(3),label="posterior(θ,n=3)")
plot!(posterior_dist(20),label="posterior(θ,n=20)")
plot!(posterior_predictive_dist(3),label="posterior(y,n=3)")
plot!(posterior_predictive_dist(20),label="posterior(y,n=20)")
savefig(joinpath(@OUTPUT, "posterior_predictive.svg"))
nothing
