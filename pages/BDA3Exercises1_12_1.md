@def title = "Bayesian Data Analysisの練習問題1.12の1をJuliaで解く"
@def tags = ["julia", "確率分布"]
@def description = "Bayesian Data Analysisの練習問題1.12の1をJuliaで解く。"
{{fill description}}
問題は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)の27ページにある。

# 1. Conditional probability
yはθ=1の時、平均1、標準偏差σの正規分布で、θ=2の時、平均2、標準偏差σの正規分布とする。
Pr(θ=1)=0.5、Pr(θ=2)=0.5とする。

## (a) 周辺分布Pr(y)を描け
σ=2とする。θ=1、2の時の正規分布はそれぞれ
```!
using Distributions, StatsPlots
y1_dist(σ) = Normal(1,σ)
y2_dist(σ) = Normal(2,σ)
plot(y1_dist(2),label="Pr(y|θ=1)",yrotation=90)
plot!(y2_dist(2),label="Pr(y|θ=2)")
savefig(joinpath(@OUTPUT, "y1y2.svg"))
nothing
```
\fig{y1y2}

となる。yの周辺分布のPDFは
$$
Pr(y)=Pr(y|θ=1)Pr(θ=1)+Pr(y|θ=2)Pr(θ=2)
$$
と計算できる。ここでPr(θ=1)=Pr(θ=2)=0.5である。
```!
Pr(y)=0.5pdf(y1_dist(2),y)+0.5pdf(y2_dist(2),y)
plot!(Pr,label="Pr(y)")
savefig(joinpath(@OUTPUT, "Pry.svg"))
nothing
```
\fig{Pry}

## (b) Pr(θ=1|y=1)の値は？
Pr(θ=1|y=1)はy=1が観測された時にθ=1である確率を計算する。ベイズの定理より
$$
Pr(θ=1|y=1)=\frac{Pr(y=1|θ=1)Pr(θ=1)}{Pr(y=1)}
$$
Pr(y=1|θ=1)はθ=1の時にy=1が観測される確率である。
Pr(θ=1)はθが1をとる確率である。この問題では0.5としてある。
θ=1の時、yは平均1、標準偏差2の正規分布に従う。y=1の時のその正規分布の確率密度がPr(y=1|θ=1)である。
θ=2の時、yは平均2、標準偏差2の正規分布に従う。y=1の時のその正規分布の確率密度がPr(y=1|θ=2)である。
```!
likelihood_θ1(σ,y) = pdf(y1_dist(σ), y)
likelihood_θ2(σ,y) = pdf(y2_dist(σ), y)
(likelihood_θ1(2,1), likelihood_θ2(2,1))
```
Pr(y=1)はθが1、2両方の場合でy=1をとる確率の合算である。
$$
Pr(y=1)=Pr(y=1|θ=1)Pr(θ=1)+Pr(y=1|θ=2)Pr(θ=2)
$$
```!
evidence(σ,y) = 0.5likelihood_θ1(σ,y) + 0.5likelihood_θ2(σ,y)
evidence(2,1)
```
```!
posterior_θ1_σ(σ,y) = 0.5likelihood_θ1(σ,y) / evidence(σ,y)
posterior_θ1_σ(2,1)
```
Pr(θ=1|y=1)=0.531である。Pr(θ=1|y=1)のグラフは以下のようになる。
```!
posterior_θ1(y)=posterior_θ1_σ(2,y)
plot(posterior_θ1,label="Pr(θ=1|y=1)", xlims=(-25,25), yrotation=90)
savefig(joinpath(@OUTPUT, "posterior_θ1.svg"))
nothing
```
\fig{posterior_θ1}

yの値が小さいほどθ=1である確率が100%に近づき、yの値が大きくなるにつれ0%に近いている。

## (c) σの値によりθの事後分布Pr(θ|y)はどのようになるか
```!
plot(y->posterior_θ1_σ(0.5,y),label="Pr(θ|y): σ=0.5", xlims=(-25,25), yrotation=90)
plot!(y->posterior_θ1_σ(1,y),label="Pr(θ|y): σ=1")
plot!(y->posterior_θ1_σ(2,y),label="Pr(θ|y): σ=2")
plot!(y->posterior_θ1_σ(3,y),label="Pr(θ|y): σ=3")
savefig(joinpath(@OUTPUT, "posterior_θ1_σ.svg"))
nothing
```
\fig{posterior_θ1_σ}

σが大きくなるにつれて確率の傾きが緩やかになる。これはθ=1,2の両方の正規分布の広がりが大きくなるためである。