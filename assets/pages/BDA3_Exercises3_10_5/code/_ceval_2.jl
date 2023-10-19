# This file was generated, do not modify it. # hide
posterior_variance_a = rand(posterior_variance_a_dist, 10)
posterior_mean_a_dist = Normal.(mean(y),posterior_variance_a)
plot(posterior_mean_a_dist, yrotation=90)
savefig(joinpath(@OUTPUT, "posterior_mean_a_dist.svg"))
posterior_variance_a
