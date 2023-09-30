@def title = "BDA3の2.11 Exercisesの6を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの6を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 6. Predictive distributions
米国のcountyごとのガン死亡数$y_j$を負の二項分布でモデル化を行う。
負の二項分布NegBin(r,p)は表が出る確率pのコインで、r回表が出るまでに出た裏の数の分布である。
```!
using Distributions, StatsPlots
plot(NegativeBinomial(5,1//6),yrotation=90,label="NegativeBinomial(5,1//6)")
savefig(joinpath(@OUTPUT, "NegativeBinomial.svg"))
nothing
```
\fig{NegativeBinomial}

この図はサイコロの1の目を5回出すのに必要なサイコロを振る回数の分布である。
この回数にサイコロの1の目を出した回数は含まれていない。

county jのガン死亡率$θ_j$の事前分布をGamma(α,β)とする。
その時、米国のcounty jのガン死亡数$y_j$を
$$
y_j|θ_j \sim \mathrm{NegBin}(α,\frac{β}{10n_j})
$$
とモデル化する。
$n_j$はcounty jの人口である。

ガンマ分布Gamma(a,b)は1時間ごとに1/bの確率で発生する不具合がa回起こるのに掛かる時間の分布である。
```!
plot(Gamma(5,6),yrotation=90,label="Gamma(5,6)")
savefig(joinpath(@OUTPUT, "Gamma.svg"))
nothing
```
\fig{Gamma}

図は1時間ごとに1/6の確率で壊れる機械が5回壊れるまでの時間の分布である。1日に5回壊れる可能性が高い。

## county jのガン死亡数$y_j$の期待値$E(y_j)$
式(1.8)は以下である。
$$
E(u)=E(E(u|v))
$$
従って、
$$
E(y_j)=E(E(y_j|θ_j))
$$
で、ガン死亡数$y_j$の期待値を計算できる。Y~NegBin(r,p)の期待値E(Y)は
$$
E(Y)=\frac{r(1-p)}{p}
$$
である。$y_j|θ_j \sim \mathrm{NegBin}(α,\frac{β}{10n_j})$なので、
$$
E(y_j|θ_j)=α\frac{1-β/10n_j}{β/10n_j} \\
=10n_j\frac{α}{β}-1
$$
である。よって、
$$
E(y_j)=E(E(y_j|θ_j)) \\
=E(10n_j\frac{α}{β}-1) \\
E(y_j)=10n_j\frac{α}{β}
$$
である。

## county jのガン死亡数$y_j$の分散$Var(y_j)$
式(1.9)は以下である。
$$
var(u)=E(var(u|v))+var(E(u|v))
$$
従って、
$$
var(y_j)=E(var(y_j|θ_j))+var(E(y_j|θ_j))
$$
で、ガン死亡数$y_j$の分散を計算できる。
Y~NegBin(r,p)の分散Var(Y)は
$$
Var(Y)=\frac{r(1-p)}{p^2}
$$
である。$y_j|θ_j \sim \mathrm{NegBin}(α,\frac{β}{10n_j})$なので、
$$
var(y_j|θ_j)=\frac{α(1-β/10n_j)}{(β/10n_j)^2} \\
=10n_j\frac{α}{β}+(10n_j)^2\frac{α}{β^2}
$$
となる。よって
$$
var(y_j)=E(var(y_j|θ_j))+var(E(y_j|θ_j)) \\
=E(10n_j\frac{α}{β}+(10n_j)^2\frac{α}{β^2})+var(10n_j\frac{α}{β}) \\
var(y_j)=10n_j\frac{α}{β}+(10n_j)^2\frac{α}{β^2}
$$
である。