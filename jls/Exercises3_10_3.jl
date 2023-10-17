using Distributions, StatsPlots

control_dist = 1.013 + TDist(32-1)*0.24/sqrt(32)
plot(control_dist)
exposed_dist = 1.173 + TDist(36-1)*0.2/sqrt(36)
plot(exposed_dist)
control_dist-exposed_dist

ycontrol=rand(control_dist,2000)
yexposed=rand(exposed_dist,2000)
dif = yexposed .- ycontrol
histogram(dif)

quantile(dif,[.025,.0975])