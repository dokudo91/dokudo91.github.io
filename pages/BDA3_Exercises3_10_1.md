@def title = "BDA3の3.10 Exercisesの1を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の3.10 Exercisesの1を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 1. Binomial and multinomial models
観測値$(y_1,\dots,y_J)$は多項分布$\mathrm{Multinomial}(n,(θ_1,\dots,θ_J))$に従う。
多項分布$\mathrm{Multinomial}(10,(0.6,0.2,0.2))$は赤6個、青2個、黄2個のボールが10個入った箱から
ランダムに取り出した時に、それぞれが取り出される回数の分布である。
```!
using Distributions, StatsPlots, Random
Random.seed!(1)
rand(Multinomial(10, [0.6,0.2,0.2]))
```
シード値1で赤7回、青0回、黄3回が取り出された。

今、θの事前分布をディリクレ分布$\mathrm{Dirichlet}(a_1,\dots,a_J)$とする。
ディリクレ分布の確率密度関数は
$$
p(θ|a)∝\prod^J_{j=1}θ^{a_j−1}
$$
である。多項分布の確率密度関数は
$$
p(y|θ) ∝ \prod^J_{j=1}θ^{y_j}_j 
$$
であり、ディリクレ分布は多項分布の共役事前分布となっている。
θの事後分布は$\mathrm{Dirichlet}(y_1+a_1,\dots,y_J+a_J)$となる。

## θの事後分布
θを$θ_1$、$θ_2$、$θ_r=1-θ_1-θ_2$で分ける。$θ_r$は$θ_1$、$θ_2$以外の全てを足したものである。
確率密度関数は
$$
p(θ_1,θ_2|y)∝θ_1^{y_1+a_1-1}θ_2^{y_2+a_2-1}(1-θ_1-θ_2)^{y_r+a_r-1}
$$
となる。

## (a) αの周辺事後分布
$$
α=\frac{θ_1}{θ_1+θ_2}
$$
$$
β=θ_1+θ_2
$$
とおく。
$$
α=\frac{θ_1}{θ_1+θ_2} \\
(θ_1+θ_2)α=θ_1 \\
θ_1=αβ
$$
$$
β=θ_1+θ_2 \\
β=αβ+θ_2 \\
θ_2=(1-α)β
$$
と変換できる。
$$
(α, β)=(\frac{θ_1}{θ_1+θ_2},θ_1+θ_2)
$$
変換のヤコビアンJを計算する。
$$
J=\begin{pmatrix}
\frac{∂α}{∂θ_1} & \frac{∂α}{∂θ_2} \\
\frac{∂β}{∂θ_1} & \frac{∂β}{∂θ_2} \\
\end{pmatrix}
$$
であるので、それぞれ計算し、
$$
J=\begin{pmatrix}
\frac{θ_2}{(θ_1+θ_2)^2} & \frac{-θ_1}{(θ_1+θ_2)^2} \\
1 & 1 \\
\end{pmatrix}
$$
$$
|J|=\frac{θ_2}{(θ_1+θ_2)^2}-\frac{-θ_1}{(θ_1+θ_2)^2}=\frac{1}{θ_1+θ_2}=\frac{1}{β}
$$
となる。

α、βの周辺事後分布を求めるために、(3)をα、βに変換する。
$$
p(α,β|y)∝\frac{1}{|J|}(αβ)^{y_1+a_1-1}((1-α)β)^{y_2+a_2-1}(1-β)^{y_r+a_r-1} \\
=βα^{y_1+a_1-1}(1-α)^{y_2+a_2-1}β^{y_1+a_1-1+y_2+a_2-1}(1-β)^{y_r+a_r-1} \\
=α^{y_1+a_1-1}(1-α)^{y_2+a_2-1}β^{y_1+a_1+y_2+a_2-1}(1-β)^{y_r+a_r-1}
$$
α部分とβ部分に分けることができ、αは$\mathrm{Beta}(y_1+a_1,y_2+a_2)$であり、
βは$\mathrm{Beta}(y_1+a_1+y_2+a_2,y_r+a_r)$である。

## (b) 結果の解釈
最初は多項分布だったが、$θ_1$、$θ_2$の2つの確率に注目するためにαを導入している。
その結果、周辺事後分布はベータ分布で表すことができ、$y_3,\dots,y_J$にも影響を受けないことが分かった。