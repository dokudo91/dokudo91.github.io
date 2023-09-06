# This file was generated, do not modify it. # hide
distribution=Exponential(2)
@show cdf(distribution, 0.5)
@show cdf(distribution, 1)
@show cdf(distribution, 2)
@show cdf(distribution, 2) - cdf(distribution, 1)
@show cdf(distribution, 10)