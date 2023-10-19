# This file was generated, do not modify it. # hide
log_likelihood_a(y,μ,σ)=sum(logpdf.(Normal(μ,σ),y))
function likelihood_matrix_a(y,μ_range,logσ_range)
    m = log_likelihood_a.(Ref(y),μ_range',exp.(logσ_range))
    exp.(m .- maximum(m))
end
μ_range=0:5//100:20
logσ_range=-2:5//100:3
contour_levels=[.0001; .001; .01; .05:.05:.95;]
matrix_a=likelihood_matrix_a(y,μ_range,logσ_range)
contour(μ_range, logσ_range, matrix_a, levels=contour_levels, title="Probability Distribution (a)")
savefig(joinpath(@OUTPUT, "contour_a.svg"))
nothing
