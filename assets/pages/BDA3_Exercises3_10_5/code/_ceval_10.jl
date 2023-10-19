# This file was generated, do not modify it. # hide
μσ_samples = wsample(μσ_matrix,matrix_b'|>vec,5000)
normal_dists = [Normal(s...) for s in μσ_samples]
zs = z.(normal_dists|>Ref, y)
histogram(zs[1])
savefig(joinpath(@OUTPUT, "histogram.svg"))
nothing
