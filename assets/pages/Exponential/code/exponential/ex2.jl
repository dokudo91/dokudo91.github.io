# This file was generated, do not modify it. # hide
using Random
Random.seed!(1)
samples=rand(Exponential(2), 10)
@show samples