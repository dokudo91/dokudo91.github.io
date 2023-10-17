@def title = "BDA3の3.10 Exercisesの4を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の3.10 Exercisesの4を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 4. Inference for a 2 × 2 table
心臓病に対する治療群と制御群の比較を行う。

| Group | 患者数 | 死者数 |
|-------|-------|-------|
| 制御群 | $n_0=674$   | $y_0=39$    |
| 治療群 | $n_1=680$   | $y_1=22$    |

死者数yは二項分布Bin(n,p)に従うとする。

## (a) 無情報事前分布
死亡率pの事前分布を無情報事前分布とする。
$$
p_0 \sim Beta(0,0)
$$
$$
p_1 \sim Beta(0,0)
$$
pの事後分布は
$$
p_0|y_0 \sim Beta(y_0,n_0-y_0)
$$
$$
p_1|y_1 \sim Beta(y_1,n_1-y_1)
$$
となる。
```!
using Distributions, StatsPlots
posterior_p0_dist=Beta(39,674-39)
posterior_p1_dist=Beta(22,680-22)
plot(posterior_p0_dist, label="control", yrotation=90)
plot!(posterior_p1_dist, label="treatment")
savefig(joinpath(@OUTPUT, "posterior_p.svg"))
nothing
```
\fig{posterior_p}

## (b) オッズ比
オッズ比の分布を調べる。オッズ比は
$$
\frac{p_1/(1-p_1)}{p_0/(1-p_0)}
$$
と定義される。
```!
using Random
Random.seed!(1)
posterior_p0 = rand(posterior_p0_dist,5000)
posterior_p1 = rand(posterior_p1_dist,5000)
odds_ratio = (posterior_p1 ./ (1 .- posterior_p1)) ./ (posterior_p0 ./ (1 .- posterior_p0))
histogram(odds_ratio, label="odds ratio", yrotation=90)
savefig(joinpath(@OUTPUT, "odds_ratio.svg"))
quantile(odds_ratio, [.025,.975])
```
\fig{odds_ratio}

この図はオッズ比のヒストグラムである。オッズ比が1の時、治療群と制御群に違いがないという意味になる。
オッズ比が0.5であれば、治療は何もしない場合と比較して、死亡数を1/2に抑えたということになる。

## (c) 事前分布に対する感度
事前分布をBeta(2,2)に変えてみる。
```!
posterior_p0_alt = rand(Beta(39+2,674-39+2),5000)
posterior_p1_alt = rand(Beta(22+2,680-22+2),5000)
odds_ratio_alt = (posterior_p1_alt ./ (1 .- posterior_p1_alt)) ./ (posterior_p0_alt ./ (1 .- posterior_p0_alt))
histogram(odds_ratio_alt, label="odds ratio", yrotation=90)
savefig(joinpath(@OUTPUT, "odds_ratio_alt.svg"))
quantile(odds_ratio_alt, [.025,.975])
```
\fig{odds_ratio_alt}

95%信用区間は[0.32, 0.91]から[0.33, 0.95]になって少し広くなった。