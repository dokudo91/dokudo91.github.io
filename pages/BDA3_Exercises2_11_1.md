@def title = "BDA3の2.11 Exercisesの1を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの1を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 1. Posterior inference
コインを10回振る。表が出た回数は3回未満だった。表が出る確率θの事前分布はBeta(4,4)だと考えている。
コインを10回振って表が3回未満だったという結果を知った後の表が出る確率θに対する事後分布はどうなるか？

## 事前分布
Beta(4,4)のPDFは
$$
Pr(θ;α,β)=\frac{θ^{α-1}(1-θ)^{β-1}}{B(α-β)}
$$
である。二項分布のPMFは
$$
Pr(k;θ)=\binom{n}{k}θ^k(1-θ)^{n-k}
$$
である。この2つの対比からBeta分布のαとβは表が出る回数に対する事前信念と解釈できる。
αとβが同じ値であれば、表が出る確率は50%であると考えている。Beta分布の平均と分散は
$$
μ=\frac{α}{α+β}
$$
$$
σ^2=\frac{αβ}{(α+β)^2(α+β+1)}
$$
と計算される。αとβの値が大きくなれば分散は小さくなる。
```!
using Distributions
using StatsPlots

prior_dist=Beta(4,4)
plot(prior_dist,label="Beta(4,4)",yrotation=90)
plot!(Beta(5,5),label="Beta(5,5)")
savefig(joinpath(@OUTPUT, "prior_dist.svg"))
nothing
```
\fig{prior_dist}

## 尤度関数
表が出る確率θが事前分布Beta(4,4)に従う時、コインを10回振って表がy回出る確率は尤度関数$p(y|θ)$で表される。
$$
p(y|θ)=\text{Binomial}(n=10,p=θ)
$$
尤度関数は二項分布に従う。
$$
p(y|θ)=\binom{n}{y}θ^y(1-θ)^{n-y}
$$
表が出る回数が3回未満となる確率は
$$
p(y<3|θ)=p(y=0|θ)+p(y=1|θ)+p(y=2|θ)
$$
と計算できる。
```!
likelihood_dist(θ)=Binomial(10,θ)
likelihood_function(y,θ)=pdf(likelihood_dist(θ),y)
likelihood_function(θ)=likelihood_function.(0:2,θ)|>sum
likelihood_function.([0.1,0.5])
```
表が出る確率θが0.1の時、yが3未満になる確率は93%で、
θ=0.5の時、yが3未満になる確率は5%である。

## 周辺分布
周辺分布のPDFは
$$
p(y)=\int^1_0 p(y∣θ)p(θ) dθ
$$
である。
```!
using QuadGK
function marginal(y)
    result, error = quadgk(θ->likelihood_function(y,θ)*pdf(prior_dist,θ), 0, 1)
    result
end
scatter(0:1:10,y->marginal(y), label="p(y)", yrotation=90)
savefig(joinpath(@OUTPUT, "marginal.svg"))
nothing
```
\fig{marginal}

積分はQuadGKパッケージを使って計算した。
事前分布がBeta(4,4)なので、y=5(表が10回中5回出る)の確率が一番高い。

## 事後分布
事後分布のPDFは
$$
p(θ∣y)=\frac{p(y∣θ)p(θ)}{p(y)}
$$
で計算できる。
```!
posterior(θ)=likelihood_function(θ)*pdf(prior_dist,θ)/sum(marginal.(0:2))
plot(posterior,label="posterior(θ)",yrotation=90)
plot!(prior_dist,label="prior(θ)")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
```
\fig{posterior}

事後分布は事前分布Beta(4,4)に対し、確率が0方向にずれ、分散が小さくなっている。

## Turing.jlで解く
この問題をTuring.jlで解く。Turing.jlはベイズ推定用のパッケージである。
Turingではyが3未満という条件を課すことはできない。
しかし、yは実測値であり、実際にはyが3未満であるということしかわからないことはありえない。
今回は実験を3回行って実測値がそれぞれ0、1、2だった場合の事後分布をシミュレートする。
```!
using Turing, Random
Random.seed!(1)
@model function coin_flip_model(y)
    θ ~ Beta(4, 4)
    @. y ~ Binomial(10, θ)
end
model = coin_flip_model(0:2)
chain = sample(model, NUTS(), 1000)
```
θの事後分布は平均0.1819、標準偏差0.0632である。
95%信用区間は0.0764から0.3252である。ヒストグラムは以下のようになる。
```!
histogram(chain[:θ],normalize=true,label="simulation",xlims=(0,1))
plot!(posterior,label="posterior(θ)")
savefig(joinpath(@OUTPUT, "simulation.svg"))
nothing
```
\fig{simulation}

3回実験してy=0、1、2だった時の事後分布の方が、1回実験してy<3だった時の事後分布よりも確率が0に寄って分散も小さくなっていることがわかる。