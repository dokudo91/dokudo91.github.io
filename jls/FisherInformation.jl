using Distributions, StatsPlots, ForwardDiff, Random
Random.seed!(1)
data=rand(Normal(1),10)
sampling_dist(θ)=Normal(θ)
log_likelihood(y, θ) = logpdf(sampling_dist(θ), y)
dlogpdf(y, θ) = ForwardDiff.gradient(x -> log_likelihood(y, x[1]), [θ])[1]
J(θ,data) = mean(dlogpdf.(data, θ).^2)

d2logpdf(y, θ) = ForwardDiff.gradient(x -> dlogpdf(y, x[1]), [θ])[1]
J2(θ,data) = -mean(d2logpdf.(data, θ))
prior_dist(θ,data)=sqrt(J(θ,data))