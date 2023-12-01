@def title = "Juliaで中心極限定理を確認する"
@def tags = ["julia", "ベイズ推定"]
@def description = "Julia Advent Calendar 2023の2日の記事です。"
{{fill description}}
この記事は[Julia Advent Calendar 2023](https://qiita.com/advent-calendar/2023/julia)用に書かれました。

# Juliaで確率分布
Juliaで確率分布を扱うには[Distributions.jl](https://github.com/JuliaStats/Distributions.jl)を使います。
確率分布でよく使われる正規分布は以下のように導入されます。
```!
using Distributions
dist=Normal()
```
Normal型のオブジェクトをdistとして生成します。
引数は何も指定していないので、平均1、標準偏差0の正規分布が作られます。
確率密度関数のグラフとして表示するには[StatsPlots.jl](https://github.com/JuliaPlots/StatsPlots.jl)を使うと簡単です。
```!
using StatsPlots
plot(dist, yrotation=90, label="Normal")
savefig(joinpath(@OUTPUT, "Normal.svg"))
nothing
```
\fig{Normal}

plot関数にNormal型のオブジェクトを渡すだけで良いです。
savefigでsvgとして保存していますが、これはこのサイトが[Franklin.jl](https://github.com/tlienart/Franklin.jl)で作られており、表示のためにそうしているだけです。

# 正規分布
正規分布が統計学でよく出てくるのは中心極限定理の所為です。
母集団の分布がなんであれ(例外はある)無作為に繰り返し測定すればその測定値の平均値は、母集団の平均値μ(母平均)を中心として分散$σ^2$(母分散)をサンプル数nで割った値$σ^2/n$の分散を持つ正規分布に近づいていくということです。
母集団の分布なんてわからないことが普通なので、独立同分布(iid)の条件を前提におけるのであれば中心極限定理は有用です。
n=1であれば平均μ、分散$σ^2$の正規分布となります。

## 母集団が一様分布の場合
母集団が一様分布の場合を考える。
```!
uniform = Uniform(2,5)
plot(uniform, yrotation=90, label="uniform", ylim=(0,0.5))
savefig(joinpath(@OUTPUT, "uniform.svg"))
nothing
```
\fig{uniform}

```!
mean(uniform), var(uniform)
```
この母集団の平均は3.5であり、分散は0.75で計算される。
この母集団から10個サンプリングする作業を100回繰り返す。
```!
using Random
Random.seed!(1)
samples = [rand(uniform,10) for _ in 1:100]
samples[1:5]
```
ログは5つまでを表示している。
それぞれ平均を計算して、そのヒストグラムを表示する。
```!
sample_means = mean.(samples)
histogram(sample_means, yrotation=90, label="sample_means", bins=20)
savefig(joinpath(@OUTPUT, "histogram.svg"))
nothing
```
\fig{histogram}

100個程度では正規分布しているようには見えない。
平均と分散は
```!
mean(sample_means), var(sample_means)
```
と計算される。母集団の母平均と母分散をn=10で割った値は
```!
mean(uniform), var(uniform) / 10
```
なので近くはある。

100回の繰り返しは少ないので、5000回繰り返す。
```!
samples = [rand(uniform,10) for _ in 1:5000]
sample_means = mean.(samples)
histogram(sample_means, yrotation=90, label="sample_means", bins=20)
savefig(joinpath(@OUTPUT, "histogram2.svg"))
nothing
```
\fig{histogram2}

正規分布に近づいた。平均と分散は
```!
mean(sample_means), var(sample_means)
```
であり、こちらも理論上の値とほぼ同等である。