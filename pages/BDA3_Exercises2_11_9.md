@def title = "BDA3の2.11 Exercisesの9を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの9を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 9. Setting parameters for a beta prior distribution
θの事前分布はBeta(α,β)分布に従うとする。その平均は0.6であり、標準偏差は0.3である。

## (a) Beta(α,β)
αとβの値は何になるか？

本文(A.3)より、
$$
α+β=\frac{E(θ)(1-E(θ))}{var(θ)}-1
$$
今、$E(θ)=0.6,var(θ)=0.3^2$より、
```!
aplusb=rationalize(0.6*(1-0.6))//rationalize(0.3)^2-1
```
α+β=5/3である。
また、引き続き本文(A.3)より、
$$
α=(α+β)E(θ), \\
β=(α+β)(1-E(θ))
$$
```!
α=aplusb*0.6
β=aplusb*(1-0.6)|>rationalize
(α,β)
```
従って、α=1、β=2/3である。

### Sketch
```!
using Distributions, StatsPlots
prior_dist=Beta(α,β)
plot(prior_dist,yrotation=90,label="Beta(α=1,β=2/3)")
savefig(joinpath(@OUTPUT, "prior.svg"))
nothing
```
\fig{prior}

## (b) カルフォルニアの死刑支持者
θはカルフォルニアの死刑支持率である。θの事前分布はBeta(1,2/3)に従うとする。
1000人のカルフォルニア住人にサンプリングしたところ、死刑支持率は65%だった。
θの事後分布はどうなるか？

```!
n=1000
y=1000*0.65
posterior_dist=Beta(α+y,β+n-y)
plot(prior_dist,yrotation=90,label="prior")
plot!(posterior_dist,label="posterior")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
```
\fig{posterior}

```!
(mean(posterior_dist),std(posterior_dist))
```
E(θ|y)=0.65、σ(θ|y)=0.015である。

## (c) 事前分布の影響
事前分布を変えて、事後分布がどの程度影響されるか確認する。
```!
plot(posterior_dist,yrotation=90,label="Beta(1+y,2/3+n-y)",xlim=(0.5,0.8))
plot!(Beta(1+y,10+n-y),label="Beta(1+y,10+n-y)")
plot!(Beta(y,n-y),label="Beta(y,n-y)")
savefig(joinpath(@OUTPUT, "sensitivity.svg"))
nothing
```
\fig{sensitivity}

図から事前分布を極端に変えない限りは事後分布は大きく変わらないことがわかる。
これはn=1000が十分に大きいためである。