using Distributions, StatsPlots
y=[10, 10, 12, 11, 9]
posterior_variance_a_dist = InverseGamma((length(y)-1)//2,1//2) * std(y)
posterior_variance_a=rand(posterior_variance_a_dist,5)
posterior_mean_a_dist = Normal.(mean(y),posterior_variance_a)
#plot(posterior_mean_a_dist)

log_likelihood_a(y,μ,σ)=sum(logpdf.(Normal(μ,σ),y))
function likelihood_matrix_a(y,μ_range,logσ_range)
    m = log_likelihood_a.(Ref(y),μ_range',exp.(logσ_range))
    exp.(m .- maximum(m))
end
μ_range=0:0.01:20
logσ_range=-2:0.01:3
contour_levels=[.0001; .001; .01; .05:.05:.95;]
matrix_a=likelihood_matrix_a(y,μ_range,logσ_range)
contour(μ_range, logσ_range, matrix_a, levels=contour_levels)

function log_likelihood_b(y,μ,σ)
    normaldist=Normal(μ,σ)
    sum(log.(cdf(normaldist, y .+ 0.5) .- cdf(normaldist, y .- 0.5)))
end
function likelihood_matrix_b(y,μ_range,logσ_range)
    m = log_likelihood_b.(Ref(y),μ_range',exp.(logσ_range))
    exp.(m .- maximum(m))
end
matrix_b=likelihood_matrix_b(y,μ_range,logσ_range)
contour(μ_range, logσ_range, matrix_b, levels=contour_levels)

using StatsBase
μ_weight_a = sum(matrix_a,dims=1)|>vec
wquantile(μ_range,μ_weight_a,[.025,.975])
σ_weight_a = sum(matrix_a,dims=2)|>vec
wquantile(exp.(logσ_range),σ_weight_a,[.025,.975])

μ_weight_b = sum(matrix_b,dims=1)|>vec
wquantile(μ_range,μ_weight_b,[.025,.975])
σ_weight_b = sum(matrix_b,dims=2)|>vec
wquantile(exp.(logσ_range),σ_weight_b,[.025,.975])

μσ_matrix = tuple.(μ_range,exp.(logσ_range)')
μσ_samples = wsample(μσ_matrix,matrix_b'|>vec,10000)
normal_dists = [Normal(s...) for s in μσ_samples]
function z(normal_dists, yi)
    n=length(normal_dists)
    lowers = cdf.(normal_dists, yi-0.5)
    uppers = cdf.(normal_dists, yi+0.5)
    quantile.(normal_dists, lowers .+ rand(n) .* (uppers .- lowers))
end

zs = z.(normal_dists|>Ref, y)
mean(abs2, (zs[1] .- zs[2]))
