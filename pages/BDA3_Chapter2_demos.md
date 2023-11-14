@def title = "BDA3のChapter2のデモ"
@def tags = ["julia", "BDA3"]
@def description = "BDA3のChapter2の内容をJuliaで計算する。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
参考は[BDA_m_demos/demos_ch2/](https://github.com/avehtari/BDA_m_demos/tree/master/demos_ch2)。

# 前置胎盤条件下での子供の性別
前置胎盤条件下で子供の性別の統計をとった。
サンプルサイズは980で女の子が437、男の子が543であった。
θを女の子が生まれる確率とする。
女の子の数は二項分布Binomial(980,θ)である。
θの事前分布を共役事前分布Beta(1,1)とすれば事後分布はBeta(1+437,1+543)となる。
```!
using Distributions, StatsPlots
prior_dist = Beta(1,1)
posterior_dist = Beta(1+437,1+543)
plot(prior_dist,yrotation=90,label="Beta(1,1)")
plot!(posterior_dist,label="Beta(438,544)")
savefig(joinpath(@OUTPUT, "posterior_dist.svg"))
nothing
```
\fig{posterior_dist}

## 事前分布の影響
437/980=0.485であるので、θの事前分布をBeta(0.485x2,(1-0.485)x2)としてみる。
```!
prior2_dist = Beta(0.485*2,(1-0.485)*2)
posterior2_dist = Beta(0.485*2+437,(1-0.485)*2+543)
plot(prior2_dist,yrotation=90,label="Beta(0.485*2,(1-0.485)*2)")
plot!(posterior2_dist,label="Beta(0.485*2+437,(1-0.485)*2+543)")
savefig(joinpath(@OUTPUT, "posterior2_dist.svg"))
nothing
```
\fig{posterior2_dist}

事前分布の影響を確認するためにBeta(0.485x20,(1-0.485)x20)、Beta(0.485x200,(1-0.485)x200)と
した場合、どのようになるか確認する。
```!
prior3_dist = Beta(0.485*20,(1-0.485)*20)
posterior3_dist = Beta(0.485*20+437,(1-0.485)*20+543)
plot(prior3_dist,yrotation=90,label="prior")
plot!(posterior3_dist,label="posterior")
savefig(joinpath(@OUTPUT, "posterior3_dist.svg"))
nothing
```
\fig{posterior3_dist}

```!
prior4_dist = Beta(0.485*200,(1-0.485)*200)
posterior4_dist = Beta(0.485*200+437,(1-0.485)*200+543)
plot(prior4_dist,yrotation=90,label="prior")
plot!(posterior4_dist,label="posterior")
savefig(joinpath(@OUTPUT, "posterior4_dist.svg"))
nothing
```
\fig{posterior4_dist}

## 信用区間
Beta(1+437,1+543)でサンプリングを行う。
```!
th = rand(posterior_dist,10000)
histogram(th,yrotation=90,label="Beta(1+437,1+543)")
savefig(joinpath(@OUTPUT, "histogram.svg"))
nothing
```
\fig{histogram}

95%信用区間を計算する。
```!
quantile(posterior_dist,[.025,.975])
```

## 男女比
今、男女比1-θ/θが興味のあるパラメータである。
```!
phi = (1 .- th) ./ th
histogram(phi,yrotation=90,label="1-θ/θ")
savefig(joinpath(@OUTPUT, "phi.svg"))
nothing
```
\fig{phi}

95%信用区間は
```!
quantile(phi,[.025,.975])
```
である。

## 共役事前分布でない事前分布
以下のような事前分布で事後分布を計算する。
```!
function noncon_prior_pdf(x)
    if x < 0.385
        x1,y1 = (0,1)
        x2,y2 = (0.385,1)
    elseif 0.385 ≤ x < 0.485
        x1,y1 = (0.385,1)
        x2,y2 = (0.485,11)
    elseif 0.485 ≤ x < 0.585
        x1,y1 = (0.485,11)
        x2,y2 = (0.585,1)
    elseif 0.585 ≤ x
        x1,y1 = (0.585,1)
        x2,y2 = (1,1)
    end
    a, b = [x1 1; x2 1]\[y1; y2]
    a*x + b
end
plot(0:0.001:1, noncon_prior_pdf,yrotation=90,label="nonconjugate")
savefig(joinpath(@OUTPUT, "noncon_prior_pdf.svg"))
nothing
```
\fig{noncon_prior_pdf}

```!
nonnormalized_posterior_noncon_pdf(x) = pdf(Binomial(980,x),437) * noncon_prior_pdf(x)
constant = sum(nonnormalized_posterior_noncon_pdf(x)*0.001 for x in 0:0.001:1)
normalized_posterior_noncon_pdf(x) = nonnormalized_posterior_noncon_pdf(x) / constant
plot(0.3:0.001:0.6, normalized_posterior_noncon_pdf,yrotation=90,label="nonconjugate")
plot!(0.3:0.001:0.6, posterior_dist,label="conjugate")
savefig(joinpath(@OUTPUT, "normalized_posterior_noncon_pdf.svg"))
nothing
```
\fig{normalized_posterior_noncon_pdf}

共役事前分布でない方は共役事前分布と比べて平均が右にずれ,分散も小さい。

## ヒストグラム
```!
s = wsample(0:0.001:1,normalized_posterior_noncon_pdf.(0:0.001:1),10000)
histogram(s,yrotation=90,label="posterior")
savefig(joinpath(@OUTPUT, "histogram.svg"))
nothing
```
\fig{histogram}
