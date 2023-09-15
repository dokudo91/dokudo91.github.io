# This file was generated, do not modify it. # hide
using Distributions, Random
Random.seed!(1)
ε = 0.1
samples(n, θ) = rand(Binomial(n, θ), 100)
first(samples(10, 0.5), 5)
