@def title = "BDA3の2.11 Exercisesの8を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの8を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 8. Normal distribution with unknown mean
n人の生徒の体重を測る。測定の結果、平均は$\bar y=150$ポンドだった。
yは$N(θ,σ^2=20^2)$に従うとする。つまり、平均はわからないが分散はわかっている状況である。
θの事前分布を$N(μ_0=180,τ_0^2=40^2)$とする。

## (a) θの事後分布
本文の(2.10)より
$$
θ|y \sim N(μ_1,τ_1^2)
$$
ここで
$$
μ_1=\frac{\frac{1}{τ_0^2}μ_0+\frac{1}{σ^2}y}{\frac{1}{τ_0^2}+\frac{1}{σ^2}}, \\
\frac{1}{τ_1^2}=\frac{1}{τ_0^2}+\frac{1}{σ^2}
$$
である。yをn回測定して、yの平均$\bar y$がわかっているので、本文(2.11)より、
$$
p(θ|y_1,...,y_n)=p(θ|\bar y)=N(θ|μ_n,τ_n^2)
$$
ここで
$$
μ_n=\frac{\frac{1}{τ_0^2}μ_0+\frac{n}{σ^2}\bar y}{\frac{1}{τ_0^2}+\frac{n}{σ^2}}, \\
\frac{1}{τ_n^2}=\frac{1}{τ_0^2}+\frac{n}{σ^2}
$$
である。全て代入すれば、θの事後分布は
$$
θ|\bar y \sim N(\frac{\frac{1}{40^2}180+\frac{n}{20^2}150}{\frac{1}{40^2}+\frac{n}{20^2}},\frac{1}{\frac{1}{40^2}+\frac{n}{20^2}})
$$
である。

### グラフで確認する
```!
using Distributions, StatsPlots
μₙ(n)=(1//40^2*180+n//20^2*150)//(1//40^2+n//20^2)
plot(1:50,μₙ,yrotation=90,label="μₙ(n)")
savefig(joinpath(@OUTPUT, "mean.svg"))
nothing
```
\fig{mean}

事後分布の平均μₙは156から150に漸近する。
```!
τₙ²(n)=1//(1//40^2+n//20^2)
plot(1:50,n->sqrt(τₙ²(n)),yrotation=90,label="τₙ(n)")
savefig(joinpath(@OUTPUT, "variance.svg"))
nothing
```
\fig{variance}

事後分布の標準偏差τₙは18から0に漸近する。
```!
posterior_dist(n)=Normal(μₙ(n),sqrt(τₙ²(n)))
plot(Normal(180,40),yrotation=90,label="prior:N(180,40^2)",xlim=(100,250))
plot!(posterior_dist(3),label="N(μₙ(3),τₙ²(3))")
plot!(posterior_dist(20),label="N(μₙ(20),τₙ²(20))")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
```
\fig{posterior}

## (b) 事後予測分布$\tilde y|\bar y$
事後予測分布$\tilde y|\bar y$の分布の平均$E(\tilde y|\bar y)$はLaw of total meanより、
$$
E(\tilde y|\bar y)=E(E(\tilde y|θ,\bar y)|\bar y)=E(θ|\bar y)=μ_n
$$
である。分散$var(\tilde y|\bar y)$はLaw of total varianceより、
$$
var(\tilde y|\bar y)=E(var(\tilde y|θ,\bar y)|\bar y)+var(E(\tilde y|θ,\bar y)|\bar y) \\
=E(σ^2|\bar y)+var(θ|\bar y) \\
=σ^2+τ_n^2
$$
(2)を代入すると、
$$
\tilde y|\bar y \sim N(\frac{\frac{1}{40^2}180+\frac{n}{20^2}150}{\frac{1}{40^2}+\frac{n}{20^2}},\frac{1}{\frac{1}{40^2}+\frac{n}{20^2}}+20^2)
$$

### グラフで確認する

```!
μ₁(n)=(1//40^2*180+n//20^2*150)//(1//40^2+n//20^2)
τ₁²(n)=1//(1//40^2+n//20^2)+20^2
posterior_predictive_dist(n)=Normal(μ₁(n),sqrt(τ₁²(n)))
plot(Normal(180,40),yrotation=90,label="prior(θ)",xlim=(100,250))
plot!(posterior_dist(3),label="posterior(θ,n=3)")
plot!(posterior_dist(20),label="posterior(θ,n=20)")
plot!(posterior_predictive_dist(3),label="posterior(y,n=3)")
plot!(posterior_predictive_dist(20),label="posterior(y,n=20)")
savefig(joinpath(@OUTPUT, "posterior_predictive.svg"))
nothing
```
\fig{posterior_predictive}

θの事前分布は180を中心に広く分布している。θはyの平均値である。
θの事後分布はnを大きくするごとに$\bar y=150$に近づき、分散も小さくなる。
yの事後分布$\tilde y|\bar y$もnを大きくするごとに150に近づくが、分散はθの事後分布と比べ大きい。

## (c) n=10の時の信用区間
```!
quantile(posterior_dist(10),[0.025,0.975])
```
$θ|\bar y$の95%信用区間は[139,163]である。
```!
quantile(posterior_predictive_dist(10),[0.025,0.975])
```
$\tilde y|\bar y$の95%信用区間は[110,192]である。

## (d) n=100の時の信用区間
```!
quantile(posterior_dist(100),[0.025,0.975])
```
$θ|\bar y$の95%信用区間は[146,154]である。
```!
quantile(posterior_predictive_dist(100),[0.025,0.975])
```
$\tilde y|\bar y$の95%信用区間は[111,190]である。