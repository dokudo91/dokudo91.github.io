# This file was generated, do not modify it. # hide
m=sum(posterior(N,203,x->pdf(gprior_dist,x))*N for N in 1:1000)
