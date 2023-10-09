using Distributions
dist=fit(Normal,[-7,-5,-3,-3,1,6,7,13,15,16,20,21] .- 8)
1-cdf(dist,-8)
1-cdf(dist,0)
(1-cdf(dist,0))/(1-cdf(dist,-8))