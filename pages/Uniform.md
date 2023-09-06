@def title = "一様分布"
@def tags = ["julia", "一様分布"]
@def description = "Juliaで一様分布を扱う。"

# 一様分布
{{fill description}}
DistributionsパッケージのUniformは指定した範囲の一様分布を生成する。
この分布から生成されるランダムな値は指定した範囲内で等確率で現れる。
StatsPlotsライブラリのplot関数にそのまま渡せば確率密度関数(PDF)のグラフが生成される。
```julia:uniform
using Distributions, StatsPlots
plot(Uniform(1, 3), ylims=(0,1), label="PDF")
savefig(joinpath(@OUTPUT, "uniform.svg"))
```
\fig{uniform}

## PDF
一様分布の確率密度関数(PDF)は
$$
P(x)=\frac{1}{b-a}
$$
で計算される。xが１から３内であれば0.5でその範囲外であれば0となる。

```julia:uniform/ex1
uniform=Uniform(1, 3)
@show pdf(uniform, 1.3)
@show pdf(uniform, 0)
```
\output{uniform/ex1}

## CDF
pdfは密度であり、xがある範囲内に入る確率を知りたい場合は累積分布関数(CDF)を用いる。
```julia:uniform/ex2
uniform=Uniform(1, 3)
@show cdf(uniform, 1.5)
@show cdf(uniform, 1.2)
@show cdf(uniform, 1.5) - cdf(uniform, 1.2)
```
\output{uniform/ex2}

Uniform(1, 3)から生成されたxが1.2から1.5の間に含まれる可能性は15%である。

## rand
実際にUniform(1, 3)から乱数を生成したい場合は標準ライブラリに含まれるrand関数にUniform(1, 3)を渡せばよい。
```julia:uniform/ex3
uniform=Uniform(1, 3)
@show rand(uniform)
@show rand(uniform)
```
\output{uniform/ex3}