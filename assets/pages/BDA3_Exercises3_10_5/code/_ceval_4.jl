# This file was generated, do not modify it. # hide
function log_likelihood_b(y,μ,σ)
    normaldist=Normal(μ,σ)
    sum(log.(cdf(normaldist, y .+ 0.5) .- cdf(normaldist, y .- 0.5)))
end
function likelihood_matrix_b(y,μ_range,logσ_range)
    m = log_likelihood_b.(Ref(y),μ_range',exp.(logσ_range))
    exp.(m .- maximum(m))
end
matrix_b=likelihood_matrix_b(y,μ_range,logσ_range)
contour(μ_range, logσ_range, matrix_b, levels=contour_levels, title="Probability Distribution (b)")
savefig(joinpath(@OUTPUT, "contour_b.svg"))
nothing
