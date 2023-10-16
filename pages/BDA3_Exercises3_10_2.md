@def title = "BDA3の3.10 Exercisesの2を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の3.10 Exercisesの2を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 2. Comparison of two multinomial observations
BushとDukakisがディベートを行った。
そのディベートの前と後にどちらを支持するか調査を行なっている。

| Survey       | Bush | Dukakis | No opinion/other | Total |
|--------------|------|---------|------------------|-------|
| pre-debate   | 294  | 307     | 38               | 639   |
| post-debate  | 288  | 332     | 19               | 639   |

Bushの支持率、Dukakisの支持率、その他の割合の事前分布をディリクレ分布とし、
Bushの支持数、Dukakisの支持数、その他の数を多項分布とする。
事後分布は[Exercises 3.10の1](BDA3_Exercises3_10_1)で求めたように
$\mathrm{Dirichlet}(y_1+a_1,\dots,y_J+a_J)$となる。
事前分布に関する情報は何もないので、$a_1=a_2=a_3=1$とする。

```!
using DataFrames, CSV
io=IOBuffer("""
Bush Dukakis other
294 307 38
288 332 19
""")
df = CSV.File(io, delim = ' ', header=true) |> DataFrame
```
```!
using Distributions
posterior_dists=Dirichlet.([collect(df[i,:]) .+ 1 for i in 1:2])
```
表の値からディベート前とディベート後の支持率のディリクレ分布をそれぞれ作った。
alpha=[295, 308, 39]とalpha=[289, 333, 20]になっている。
```!
function predict(dist)
    θs = rand(dist)
    rand(Multinomial(639, θs))
end
θs = rand(posterior_dists[1])
@show θs
rand(Multinomial(639, θs))
```
この値は支持率の事後分布であるディリクレ分布からθをサンプリングし、それを元に多項分布を生成し、639人を振り分けたものである。

この作業を1000回行なってそのヒストグラムを表示する。
```!
using StatsPlots
posterior1_predicts = [predict(posterior_dists[1]) for _ in 1:5000]
yBush1=getindex.(posterior1_predicts, 1)
yDukakis1=getindex.(posterior1_predicts, 2)
stephist(yBush1, label="pre-debate Bush", xlim=(220,380), yrotation=90)
stephist!(yDukakis1, label="pre-debate Dukakis")
savefig(joinpath(@OUTPUT, "posterior1.svg"))
nothing
```
\fig{posterior1}

```!
posterior2_predicts = [predict(posterior_dists[2]) for _ in 1:5000]
yBush2=getindex.(posterior2_predicts, 1)
yDukakis2=getindex.(posterior2_predicts, 2)
stephist(yBush2, label="post-debate Bush", xlim=(220,380), yrotation=90)
stephist!(yDukakis2, label="post-debate Dukakis")
savefig(joinpath(@OUTPUT, "posterior2.svg"))
nothing
```
\fig{posterior2}

## 支持率の差
BushとDukakisの支持率にのみ注目する。
$$
α_1=\frac{θ^{pre}_1}{θ^{pre}_1+θ^{pre}_2}
$$
$$
α_2=\frac{θ^{post}_1}{θ^{post}_1+θ^{post}_2}
$$
とする。[Exercises 3.10の1](BDA3_Exercises3_10_1)で求めたように事後分布はそれぞれ
$α_1|y=\mathrm{Beta}(295,308)$、$α_2|y=\mathrm{Beta}(289,333)$となる。
```!
α1_dist=Beta(295,308)
α2_dist=Beta(289,333)
plot(α1_dist, label="pre-debate Bush", yrotation=90)
plot!(α2_dist, label="post-debate Bush")
savefig(joinpath(@OUTPUT, "α_dist.svg"))
nothing
```
\fig{α_dist}

この確率αはBushとDukakisの支持率を全体としたものとなる。(1-αがDukakisの支持率になる。)
その差$α_2-α_1$のヒストグラムを求める。
```!
dif = rand(α2_dist, 5000) .- rand(α1_dist, 5000)
histogram(dif, label="α2 - α1", yrotation=90)
savefig(joinpath(@OUTPUT, "dif.svg"))
nothing
```
\fig{dif}

ディベート後にBush側が支持率を増やしたと推測する事後分布は$α_2-α_1>0$となる割合を考えればよい。
```!
count(>(0), dif) / length(dif)
```
ディベートは約19%の確率でBushに有利に働いたと推測している。