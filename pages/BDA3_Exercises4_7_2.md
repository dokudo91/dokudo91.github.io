@def title = "BDA3の4.7 Exercisesの2を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の4.7 Exercisesの2を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 2. Normal approximation

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

## 正規分布近似
本文4.1の式(4.2)より
$$
p(θ|y) \approx N(\hat θ, [I(\hat θ)]^{-1})
$$
と近似できる。$\hat θ$は事後分布のモードである。I(θ)は観測情報(observed information)であり、
$$
I(θ)=-\frac{d^2}{dθ^2}\log{p(θ|y)}
$$
と定義される。式(3)から
$$
\log{p(y|α,β)}=\text{constant}+y\log{(\text{logit}^{-1}(α+βx))}+(n-y)\log{(1-\text{logit}^{-1}(α+βx))}
$$
ここで、$\text{logit}^{-1}(α+βx)$はロジスティック関数
$$
\text{logit}^{-1}(α+βx)=\frac{1}{1+\exp{(-(α+βx))}}
$$
となる。(6)式より
$$
I(α,β)=-\begin{bmatrix}
    \frac{d^2}{dα^2}\log{(\prod^k_{i=1}p(y_i|α,β,n_i,x_i))} & \frac{d^2}{dαdβ}\log{(\prod^k_{i=1}p(y_i|α,β,n_i,x_i))} \\
    \frac{d^2}{dαdβ}\log{(\prod^k_{i=1}p(y_i|α,β,n_i,x_i))} & \frac{d^2}{dβ^2}\log{(\prod^k_{i=1}p(y_i|α,β,n_i,x_i))}
\end{bmatrix} \\
=-\begin{bmatrix}
    \sum^k_{i=1}\frac{d^2}{dα^2}\log{(p(y_i|α,β,n_i,x_i))} & \sum^k_{i=1}\frac{d^2}{dαdβ}\log{(p(y_i|α,β,n_i,x_i))} \\
    \sum^k_{i=1}\frac{d^2}{dαdβ}\log{(p(y_i|α,β,n_i,x_i))} & \sum^k_{i=1}\frac{d^2}{dβ^2}\log{(p(y_i|α,β,n_i,x_i))}
\end{bmatrix}
$$
(7)式をα、βで偏微分する。
$$
\frac{d^2}{dα^2}\log{p(y|α,β)}=-\frac{n\exp{(α+βx)}}{(1+\exp{(α+βx)})^2}
$$
$$
\frac{d^2}{dαdβ}\log{p(y|α,β)}=-\frac{nx\exp{(α+βx)}}{(1+\exp{(α+βx)})^2}
$$
$$
\frac{d^2}{dβ^2}\log{p(y|α,β)}=-\frac{nx^2\exp{(α+βx)}}{(1+\exp{(α+βx)})^2}
$$
(9)式に(10)-(12)式を代入する。
$$
I(α,β)=\begin{bmatrix}
    \sum^k_{i=1}\frac{n\exp{(α+βx_i)}}{(1+\exp{(α+βx_i)})^2} & \sum^k_{i=1}\frac{nx_i\exp{(α+βx_i)}}{(1+\exp{(α+βx_i)})^2} \\
    \sum^k_{i=1}\frac{nx_i\exp{(α+βx_i)}}{(1+\exp{(α+βx_i)})^2} & \sum^k_{i=1}\frac{nx_i^2\exp{(α+βx_i)}}{(1+\exp{(α+βx_i)})^2}
\end{bmatrix}
$$
p(α,β|y)のモードとなる$\hat α$、$\hat β$がわかれば、正規分布近似
$$
p(\hat α, \hat β|y) \approx N([\hat α \ \hat β], [I(\hat α, \hat β)]^{-1})
$$
が導出できる。
```!
using StatsPlots
x=[-0.86,-0.3,-0.05,0.73]
n=5
y=[0,1,3,5]
logistic(x)=1/(1+exp(-x))
function likelihood_yi(y,α,β,n,x)
    θ=logistic(α+β*x)
    θ^y * (1-θ)^(n-y)
end
likelihood_y(y,α,β,n,x)=prod(likelihood_yi.(y,α,β,n,x))
contour(-5:0.1:5,-10:0.1:30,(α,β)->likelihood_y(y,α,β,n,x), yrotation=90)
savefig(joinpath(@OUTPUT, "likelihood_y.svg"))
max_index = argmax(likelihood_y.(y|>Ref,(0:0.01:2)',5:0.01:10,n,x|>Ref))
matrix_αβ = tuple.((0:0.01:2)',5:0.01:10)
α, β = matrix_αβ[max_index]
```
\fig{likelihood_y}

この図は正規分布近似していない尤度関数の確率密度である。
αとβの事後分布モードは(0.85, 7.76)と分かった。

```!
using Distributions, LinearAlgebra
expx = exp.(α .+ β .* x)
expx12 = (1 .+ expx) .^2
dlogpdα = sum(n .* expx ./ expx12)
dlogpdαβ = sum(n .* x .* expx ./ expx12)
dlogpdβ = sum(n .* x .^2 .* expx ./ expx12)
Iαβ = [dlogpdα dlogpdαβ; dlogpdαβ dlogpdβ]
normalappro = MvNormal([α, β], inv(Iαβ))
contour(-5:0.1:5,-10:0.1:30,(α,β)->pdf(normalappro, [α, β]))
savefig(joinpath(@OUTPUT, "normalappro.svg"))
nothing
```
\fig{normalappro}

事後分布のモードを使った正規分布近似はモード周辺はよく近似できているが離れるほど不正確になっている。
また、正規分布近似ではβがマイナスを取り得るが、βがマイナスであるということは
薬の量が増えると死亡率が下がるという意味であり、現実的にはあり得ない。