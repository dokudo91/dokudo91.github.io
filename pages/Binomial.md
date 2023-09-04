@def title = "コンストラクタ"
@def tags = ["julia", "二項分布"]
@def description = "Juliaで二項分布を扱う。"

# 二項分布
{{fill description}}
`Binomial(10, 0.6)`は表が出る確率が0.6のコインを１０回投げる時の二項分布を生成する。
```julia:binomial
using Distributions
using StatsPlots
plot(Binomial(10, 0.6), xlabel="number of trials", ylabel="probability", label=nothing, xticks=1:1:10)
savefig(joinpath(@OUTPUT, "binomial_10_06.svg"))
```
\fig{binomial_10_06}

グラフは確率質量関数(PMF:Probability Mass Function)を表している。表が0.6の確率で出るコイントスを10回行うと表が6回出る確率が一番大きい。
```julia:./code/ex1
@show pdf(Binomial(10, 0.6), 5)
@show pdf(Binomial(10, 0.6), 6)
@show pdf(Binomial(10, 0.6), 7)
```
\output{./code/ex1}

その確率は約25%になる。pdfはProbability Density Function(確率密度関数)の略。  

離散確率変数はPMFで確率変数が特定の値(ここでは6)を取る確率を計算する。
連続確率変数はPDFで確率変数が特定の範囲に入る確率を計算する。
これは連続確率変数では密度として定義しなければ意味をなさないためである。
DistributionsパッケージではPDFもPMFもpdf関数で計算される。  

二項分布のPMFを計算する式は以下のようになる。
$$
P(X = 6) = \binom{10}{6} 0.6^6 (1-0.6)^{10-6}
$$