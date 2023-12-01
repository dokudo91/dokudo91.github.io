using Distributions
using StatsPlots
using Random
uniform = Uniform(2,5)
mean(uniform)
var(uniform)

samples = [rand(uniform,10) for _ in 1:1000]
sample_means = mean.(samples)
histogram(sample_means)
mean(sample_means), var(sample_means)