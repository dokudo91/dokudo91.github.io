# This file was generated, do not modify it. # hide
uniform=Uniform(1, 3)
@show cdf(uniform, 1.5)
@show cdf(uniform, 1.2)
@show cdf(uniform, 1.5) - cdf(uniform, 1.2)