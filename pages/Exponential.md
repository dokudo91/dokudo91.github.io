@def title = "指数分布"
@def tags = ["julia", "指数分布"]
@def description = "Juliaで指数分布を扱う。"

# 指数分布
{{fill description}}
指数分布はPDFが以下で表される分布である。
$$
P(x|λ)=λe^{−λx}
$$

```julia:exponential
using Distributions, StatsPlots
plot(Exponential(2), label="PDF")
savefig(joinpath(@OUTPUT, "exponential.svg"))
```
\fig{exponential}

`Exponential(2)`は$λ=\frac{1}{2}$の指数分布を生成する。

## 具体例：コーヒーショップ
コーヒーショップに訪れる客の間隔を指数分布でモデル化する。単位時間を1分とするとCDF(累積分布関数)は次の客がその時間内に来る確率となる。
```julia:exponential/ex1
distribution=Exponential(2)
@show cdf(distribution, 0.5)
@show cdf(distribution, 1)
@show cdf(distribution, 2)
@show cdf(distribution, 2) - cdf(distribution, 1)
@show cdf(distribution, 10)
```
\output{exponential/ex1}

次の客が30秒内に来る確率は22%であり、1分以上2分未満に来る確率は24%となる。

### rand
rand関数で客が来る時間をシミュレートできる。
```julia:exponential/ex2
using Random
Random.seed!(1)
samples=rand(Exponential(2), 10)
@show samples
```
\output{exponential/ex2}

`samples=rand(Exponential(2), 10)`で指数分布Exponential(2)から10個乱数を生成し、配列に入れたものを出力している。
samplesは客が前の客から何分後に来たかを表している。1人目は0.188分後に来て、２人目はその4.29分後に来ている。
その平均は
```julia:exponential/ex3
@show mean(samples)
```
\output{exponential/ex3}
約3分となっている。この値はサンプル数を増やすにつれて$\frac{1}{λ}=2$に近づいていく。
$$
E[P(x|λ)] = \frac{1}{λ}
$$
```julia:exponential/ex4
@show mean(rand(Exponential(2), 10))
@show mean(rand(Exponential(2), 100))
@show mean(rand(Exponential(2), 1000))
```
\output{exponential/ex4}
