# This file was generated, do not modify it. # hide
sum((m-N)^2*posterior(N,203,x->pdf(gprior_dist,x)) for N in 1:1000)|>sqrt
