# This file was generated, do not modify it. # hide
α1_dist=Beta(295,308)
α2_dist=Beta(289,333)
plot(α1_dist, label="pre-debate Bush", yrotation=90)
plot!(α2_dist, label="post-debate Bush")
savefig(joinpath(@OUTPUT, "α_dist.svg"))
nothing
