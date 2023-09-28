# This file was generated, do not modify it. # hide
using Turing, Random
Random.seed!(1)
@model function coin_flip_model(y)
    θ ~ Beta(4, 4)
    @. y ~ Binomial(10, θ)
end
model = coin_flip_model(0:2)
chain = sample(model, NUTS(), 1000)
