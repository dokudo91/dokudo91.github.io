using Distributions, StatsPlots
aplusb=rationalize(0.6*(1-0.6))//rationalize(0.3)^2-1
α=aplusb*0.6
β=aplusb*(1-0.6)|>rationalize
prior_dist=Beta(α,β)