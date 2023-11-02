@def title = "BDA3の4.7 Exercisesの3を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の4.7 Exercisesの3を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 3. Normal approximation to the marginal posterior distribution of an estimand

|x|n|y|
|---|---|---|
|-0.86|5|0|
|-0.3|5|1|
|-0.05|5|3|
|0.73|5|5|

xを薬の量。nを動物の数。yを死亡数とする。
薬の量を変えて、動物実験を行い、死亡数を観測した。
yは二項分布Bin(n,θ)に従うとする。θは死亡率である。
θはx(薬の量)が大きくなれば大きくなると考えられる。
0≤θ≤1であるので、logit関数を用いて
$$
\text{logit}(θ)=α+βx
$$
とする。logit関数は
$$
\text{logit}(θ)=\log{(\frac{θ}{1-θ})}
$$
である。yは二項分布Bin(n,θ)に従うので尤度関数は
$$
p(y|α,β,n,x)∝θ^y(1-θ)^{n-y} \\
=[\text{logit}^{-1}(α+βx)]^y[1-\text{logit}^{-1}(α+βx)]^{n-y}
$$
となる。
αとβの事前分布をUniform(0,1)とすると事後分布は
$$
p(α,β|y,n,x)∝p(α,β)p(y|α,β,n,x) \\
=\prod^k_{i=1}p(y_i|α,β,n_i,x_i)
$$
である。

## 50%致死量 LD50
50%致死量(LD50)という量を定義する。
この量は死亡率が50%となるxの値である。
$$
E(\frac{y}{n})=\text{logit}^{-1}(α+βx)=0.5
$$
xについて解いて、
$$
α+βx=\text{logit}(0.5)=0 \\
x=-\frac{α}{β}
$$
である。
LD50を推定対象とし、$θ_L=-\frac{α}{β}$とおく。変数変換のため、$θ_β=β$とする。
α、βを$θ_L$、$θ_β$へ変数変換する。
本文p.62の式(2.19)より確率密度関数の変換は
$$
p(θ_L,θ_β|y)=p(α,β|y)|J|
$$
となる。Jはヤコビアンである。
$$
J=\begin{bmatrix}
    \frac{\partial α}{\partial θ_L} & \frac{\partial α}{\partial θ_β} \\
    \frac{\partial β}{\partial θ_L} & \frac{\partial β}{\partial θ_β}
\end{bmatrix}
=\begin{bmatrix}
    -θ_β & -θ_L \\
    0 & 1
\end{bmatrix}
$$
(3),(4),(7),(8)と$α=-θ_Lθ_β$、$β=θ_β$より
$$
p(θ_L,θ_β|y)∝\prod^k_{i=1}p(y_i|α,β,n_i,x_i)|θ_β| \\
=\prod^k_{i=1}[\text{logit}^{-1}(-θ_Lθ_β+θ_βx)]^y[1-\text{logit}^{-1}(-θ_Lθ_β+θ_βx)]^{n-y}|θ_β|
$$
となる。
LD50の周辺分布に興味があるので、
$$
p(θ_L|y)∝\int \prod^k_{i=1}[\text{logit}^{-1}(-θ_Lθ_β+θ_βx)]^y[1-\text{logit}^{-1}(-θ_Lθ_β+θ_βx)]^{n-y}|θ_β|dθ_β
$$
を計算する。

```!
using Distributions, StatsPlots

logit(x)=log(x/(1-x))
logistic(x)=1/(1+exp(-x))

x=[-0.86,-0.3,-0.05,0.73]
n=5
y=[0,1,3,5]

function likelihood_yi(y, θL, θβ, n, x)
    θ = logistic(-θL * θβ + θβ * x)
    θ^y * (1-θ)^(n-y)
end
likelihood_y(y, θL, θβ, n, x)=prod(likelihood_yi.(y, θL, θβ, n, x))

posteriorθLθβ(θL, θβ, y, n, x) = abs(θβ) * likelihood_y(y, θL, θβ, n, x)
posteriorθL = sum(posteriorθLθβ.((-1:0.01:1)', 0:0.01:10, y|>Ref, n, x|>Ref), dims=1) |> vec
histogram(wsample(-1:0.01:1, posteriorθL, 10000), label="posterior θL", yrotation=90)
savefig(joinpath(@OUTPUT, "posteriorθL.svg"))
nothing
```
\fig{posteriorθL}

## 正規分布近似
LD50の正規分布近似を行う。本文(4.2)式から
$$
p(θ_L|y) \approx N(\hat θ_L, [I(\hat θ_L)]^{-1})
$$
と近似できる。θ_Lのモードは
```!
vec(-1:0.01:1)[argmax(posteriorθL)]
```
-0.11である。
$$
I(θ_L)=-\frac{d^2}{θ_L^2}\log{p(θ_L|y)}
$$
であるので、２階微分を計算する必要がある。