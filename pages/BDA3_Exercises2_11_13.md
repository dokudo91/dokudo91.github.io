@def title = "BDA3の2.11 Exercisesの13を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの13を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 13. Discrete data

## ポアソン分布の共役事前分布と事後分布
本文p.43のPoisson modelの内容を復習する。

y|θはポアソン分布Poisson(θ)に従う。確率密度関数は
$$
p(y|θ)=\frac{θ^ye^{-θ}}{y!}
$$
である。観測データが$y=(y_1,...,y_n)$と得られた時、確率密度関数は
$$
p(y|θ)=\prod_{i=1}^n\frac{1}{y_i!}θ^{y_i}e^{-θ} \\
∝ θ^{t(y)}e^{-nθ}
$$
となる。ここで$t(y)=\sum_{i=1}^ny_i$である。指数型分布族の形で表すと
$$
p(y|θ) ∝ e^{t(y)\mathrm{log}θ}e^{-nθ}
$$
となる。

ガンマ分布はポアソン分布の共役事前分布である。
θ~Gamma(α,β)とする。確率密度関数は指数型分布族の形で表すと
$$
p(θ)∝θ^{α-1}e^{-βθ}=e^{(α-1)\mathrm{log}θ}e^{-βθ}
$$
である。事後分布p(θ|y)はベイズの定理より
$$
p(θ|y)∝p(θ)p(y|θ)
$$
なので、
$$
p(θ|y)∝e^{(α-1)\mathrm{log}θ}e^{-βθ}e^{t(y)\mathrm{log}θ}e^{-nθ} \\
=e^{(α+t(y)-1)\mathrm{log}θ}e^{-(β+n)θ}
$$
と計算できる。これはガンマ分布Gamma(α+t(y), β+n)の形である。
$t(y)=\sum_{i=1}^ny_i$はポアソン分布の十分統計量であり、事後分布は個別の$y_i$に依存せず、その合計にのみ依存している。

## (a) 致命的事故の事後予測分布$\tilde y|y$
飛行機の致命的事故の表がある。
```!
using DataFrames, CSV
io=IOBuffer("""
Year FatalAccidents PassengerDeaths DeathRate
1976 24 734 0.19
1977 25 516 0.12
1978 31 754 0.15
1979 31 877 0.16
1980 22 814 0.14
1981 21 362 0.06
1982 26 764 0.13
1983 20 809 0.13
1984 16 223 0.03
1985 22 1066 0.15
""")
df = CSV.File(io, delim = ' ', header=true) |> DataFrame
```
致命的事故の数yはPoisson(θ)に従うとする。
θの事前分布を指定して、事後分布を解析する。
### θの事後分布θ|y
θの事前分布について何の情報も持っていないので、
[Exercises 12](../BDA3_Exercises2_11_12)で求めたジェフェリーズ事前分布$p(θ)=θ^{-1/2}$を使う。
$p(θ)=θ^{-1/2}$はGamma(1/2, 0)の形なので、共役事前分布となり、事後分布はGamma(1/2+t(y), n)となる。
事前分布$p(θ)=θ^{-1/2}$は確率分布としては不適であるが、事後分布Gamma(1/2+t(y), n)は解析可能である。
```!
using Distributions, StatsPlots
n=length(df.FatalAccidents)
fa_rate_posterior_dist=Gamma(1//2+sum(df.FatalAccidents),1//n)
plot(fa_rate_posterior_dist,yrotation=90,label="θ_posterior")
savefig(joinpath(@OUTPUT, "fa_rate_posterior.svg"))
nothing
```
\fig{fa_rate_posterior}

Poisson(θ)に従う致命的事故の数yのθの事後分布の図である。
この事後分布は1976年から1985年までのFatalAccidentsの観測結果を用いて導かれた。

### 事後予測分布$\tilde y|y$
事後予測分布$\tilde y|y$の確率密度関数は
$$
p(\tilde y|y)=\int p(\tilde y|θ)p(θ|y)dθ
$$
で計算される。ここでは、積分部分は単純化して和で計算する。
```!
fa_dists=[Poisson(θ) for θ in 0:0.1:100]
fa_rate_posterior_pdfs=[pdf(fa_rate_posterior_dist,θ) for θ in 0:0.1:100]
predictive_fa_pdf(y)=sum(pdf.(fa_dists,y) .* fa_rate_posterior_pdfs .* 0.1)
bar(1:100,predictive_fa_pdf,yrotation=90,label="posterior predictive y")
savefig(joinpath(@OUTPUT, "predictive_fa_pdf.svg"))
nothing
```
\fig{predictive_fa_pdf}

分位数を計算する。
```!
function fquantile(py,yvalues,q)
    index=findfirst(≥(q),cumsum([py(y) for y in yvalues]))
    getindex(yvalues,index)
end
fquantile.(predictive_fa_pdf, Ref(1:100), [.025, .975])
```
よって、95%信用区間は[14, 34]である。
1986年に起こる致命的飛行機事故は95%の確率で14回から34回である。

## (b) 乗客の総飛行距離を考慮に入れて推測する
全乗客の総飛行距離が増えれば飛行機事故は増えると考えられる。
この考えをベイズ推定に反映する。
$$
y_i|x_i,θ \sim \mathrm{Poisson}(x_iθ)
$$
$x_i$はi番目の年の全乗客の総飛行距離である。
致命的飛行機事故数$y_i$は$\mathrm{Poisson}(x_iθ)$に従うとする。
全乗客の総飛行距離$x_i$は以下のように計算する。
```!
passenger_miles = df.PassengerDeaths ./ df.DeathRate .*10^8
df.PassengerMiles=passenger_miles
df
```
DeathRateは１乗客、100マイルごとの死亡率であるので、死亡数を死亡率で割れば
全乗客の総飛行距離になる。
### θの事後分布θ|y,x
θの事前分布をGamma(α, β)とする。$y_i|x_i,θ \sim \mathrm{Poisson}(x_iθ)$とした時、事後分布はどうなるか？
指数型分布族の形にして計算する。
$$
p(y_i|x_i,θ)∝θ^{y_i}e^{-x_iθ}
$$
全ての年の観測データを考慮して、
$$
p(y|x,θ)∝θ^{t(y)}e^{-t(x)θ}=e^{t(y)\mathrm{log}θ}e^{-t(x)θ}
$$
ここで、$t(y)=\sum_{i=1}^ny_i$、$t(x)=\sum_{i=1}^nx_i$である。
θの事前分布をGamma(α, β)とすると
$$
p(θ)∝θ^{α-1}e^{-βθ}=e^{(α-1)\mathrm{log}θ}e^{-βθ}
$$
事後分布$p(θ|y,x)∝p(θ)p(y|x,θ)$は
$$
p(θ|y,x)∝e^{(α+t(y)-1)\mathrm{log}θ}e^{-(β+t(x))θ}
$$
である。したがって事後分布はGamma(α+t(y), β+t(x))である。

事前分布をGamma(1/2, 0)とすると事後分布はGamma(1/2+t(y), t(x))である。
JuliaではGamma(α, 1/β)となっているので、注意する。
```!
using Printf
b_posterior_dist=Gamma(1//2+sum(df.FatalAccidents),1/sum(passenger_miles))
plot(b_posterior_dist,yrotation=90,label="Gamma($(shape(b_posterior_dist)), $(@sprintf("%.2e", scale(b_posterior_dist))))")
savefig(joinpath(@OUTPUT, "b_posterior_dist.svg"))
nothing
```
\fig{b_posterior_dist}

### 事後予測分布$\tilde y|y,x$
データにない1986年の致命的飛行機事故数$\tilde y|y,x$を推定する。
ここで1986年の全乗客の総飛行距離xは$8*10^{11}$マイルとする。
```!
θrange=1e-11:1e-13:1e-10
b_fa_dists=[Poisson(8*10^11*θ) for θ in θrange]
b_posterior_pdfs=[pdf(b_posterior_dist,θ) for θ in θrange]
predictive_fa_pdf(y)=sum(pdf.(b_fa_dists,y) .* b_posterior_pdfs .* 1e-13)
bar(0:100,predictive_fa_pdf,yrotation=90,label="predictive_fa_pdf")
savefig(joinpath(@OUTPUT, "predictive_fa_pdf.svg"))
nothing
```
\fig{predictive_fa_pdf}

図は事後予測分布$\tilde y|y,x$の確率質量関数である。
```!
fquantile.(predictive_fa_pdf, Ref(0:100), [.025, .975])
```
95%信用区間は[22, 46]である。
(a)では[14, 34]と推測したので、飛行機事故数は多くなる方向にシフトしている。
(b)では飛行距離が増えれば飛行機事故が増えると考えており、結果だけ見るとその仮定は正しそうである。

## (c) (a)の条件で乗客死亡者数をyとする
(a)の条件で乗客死亡者数をyとして推測する。
### θの事後分布θ|y
```!
df
```
```!
n=length(df.PassengerDeaths)
c_posterior_dist=Gamma(1//2+sum(df.PassengerDeaths),1//n)
plot(c_posterior_dist,yrotation=90,label="c_posterior_dist",xlim=(500,1000))
savefig(joinpath(@OUTPUT, "c_posterior_dist.svg"))
nothing
```
\fig{c_posterior_dist}

### 事後予測分布$\tilde y|y$
```!
crange=600:0.1:800
c_dists=[Poisson(θ) for θ in crange]
c_posterior_pdfs=[pdf(c_posterior_dist,θ) for θ in crange]
c_predictive_pdf(y)=sum(pdf.(c_dists,y) .* c_posterior_pdfs .* 0.1)
bar(500:1200,c_predictive_pdf,yrotation=90,label="c_predictive_pdf")
savefig(joinpath(@OUTPUT, "c_predictive_pdf.svg"))
nothing
```
\fig{c_predictive_pdf}

分位数を計算する。
```!
fquantile.(c_predictive_pdf, Ref(500:1200), [.025, .975])
```

95%信用区間は[638, 747]である。

## (d) (b)の条件で乗客死亡者数をyとする
```!
d_posterior_dist=Gamma(1//2+sum(df.PassengerDeaths),1/sum(passenger_miles))
plot(d_posterior_dist,yrotation=90,label="d_posterior_dist")
savefig(joinpath(@OUTPUT, "d_posterior_dist.svg"))
nothing
```
\fig{d_posterior_dist}

### 事後予測分布$\tilde y|y,x$
```!
dθrange=1e-9:1e-12:2e-9
d_pd_dists=[Poisson(8*10^11*θ) for θ in dθrange]
d_posterior_pdfs=[pdf(d_posterior_dist,θ) for θ in dθrange]
d_predictive_pd_pdf(y)=sum(pdf.(d_pd_dists,y) .* d_posterior_pdfs .* 1e-12)
bar(500:1200,d_predictive_pd_pdf,yrotation=90,label="d_predictive_pd_pdf")
savefig(joinpath(@OUTPUT, "d_predictive_pd_pdf.svg"))
nothing
```
\fig{d_predictive_pd_pdf}

```!
fquantile.(d_predictive_pd_pdf, Ref(500:1200), [.025, .975])
```
95%信用区間は[904, 1034]である。

## (e) (a)-(d)の分析の妥当性
飛行距離が増えれば死亡事故が増えると考えるのは妥当である。
しかし、年を追うごとに技術の発展や業務の改善がなされ、死亡事故は減ることも考えられる。
(b)、(d)は飛行距離しか考えていないので、最新の年の死亡数が最も高くなると予測しているが、
実際には1986年の事故は22件、死亡者数は546人であった。
このモデル化に関してはExercises 3.12, 6.2, 6.3, 8.14でも再検討を行う。