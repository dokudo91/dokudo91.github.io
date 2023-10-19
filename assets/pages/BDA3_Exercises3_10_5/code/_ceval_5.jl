# This file was generated, do not modify it. # hide
using StatsBase
μ_weight_a = sum(matrix_a,dims=1)|>vec
μ_quantile_a=wquantile(μ_range,μ_weight_a,[.025,.975])
σ_weight_a = sum(matrix_a,dims=2)|>vec
σ_quantile_a=wquantile(exp.(logσ_range),σ_weight_a,[.025,.975])

μ_weight_b = sum(matrix_b,dims=1)|>vec
μ_quantile_b=wquantile(μ_range,μ_weight_b,[.025,.975])
σ_weight_b = sum(matrix_b,dims=2)|>vec
σ_quantile_b=wquantile(exp.(logσ_range),σ_weight_b,[.025,.975])

csv="""分位数,0.025,0.975
(a) μ,$(join(round.(μ_quantile_a;digits=2),","))
(b) μ,$(join(round.(μ_quantile_b;digits=2),","))
(a) σ,$(join(round.(σ_quantile_a;digits=2),","))
(b) σ,$(join(round.(σ_quantile_b;digits=2),","))"""
write(joinpath(@OUTPUT,"quantile.csv"), csv)
nothing
