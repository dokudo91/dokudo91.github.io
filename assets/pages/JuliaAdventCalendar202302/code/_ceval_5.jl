# This file was generated, do not modify it. # hide
using Random
Random.seed!(1)
samples = [rand(uniform,10) for _ in 1:100]
samples[1:5]
