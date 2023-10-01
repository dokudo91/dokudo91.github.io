using Distributions, StatsPlots

μₙ(n)=(1//40^2*180+n//20^2*150)//(1//40^2+n//20^2)
τₙ²(n)=1//(1//40^2+n//20^2)
μ₁(n)=(1//40^2*180+n//20^2*150)//(1//40^2+n//20^2)
τ₁²(n)=1//(1//40^2+n//20^2)+20^2
posterior_dist(n)=Normal(μₙ(n),sqrt(τₙ²(n)0)
posterior_predictive_dist(n)=Normal(μ₁(n),sqrt(τ₁²(n)))
quantile(posterior_predictive_dist(10),[0.05,0.95])