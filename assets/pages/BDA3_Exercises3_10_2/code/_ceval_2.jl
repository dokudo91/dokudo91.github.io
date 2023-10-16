# This file was generated, do not modify it. # hide
using Distributions
posterior_dists=Dirichlet.([collect(df[i,:]) .+ 1 for i in 1:2])
