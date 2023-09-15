@def title = "大数の弱法則をJuliaで確認する"
@def tags = ["julia", "大数の弱法則"]
@def description = "大数の弱法則をJuliaで確認する。"
{{fill description}}

# 大数の弱法則
大数の弱法則は以下である。
$$
\text{if } y \sim \text{Bin}(n, \theta), \\
\text{ then } \Pr\left(\left|\frac{y}{n} - \theta\right| > \varepsilon \, \Big| \, \theta\right) \rightarrow 0 \text{ as } n \rightarrow \infty, \\
\text{ for any } \theta \text{ and any fixed value of } \varepsilon > 0
$$
yはベルヌーイ分布に従う。ベルヌーイ分布は表が出る確率がθのコインでn回コインを振って表が出る回数の従う分布である。
θ=0.1、n=10の時、y=1が最も確率が高く、y=10は最も確率が低くなる。確率密度関数は
$$
p(y|\theta) = \text{Bin}(y|n, \theta) = \binom{n}{y} \theta^y (1 - \theta)^{n-y}
$$
である。
大数の弱法則は雑に言えば、コインを振る回数を増やせば、表が出る回数yは表が出る確率θの割合に近いていくということである。

## Julia code
samples関数でベルヌーイ分布から100個の乱数を生成する。
```!
using Distributions, Random
Random.seed!(1)
ε = 0.1
samples(n, θ) = rand(Binomial(n, θ), 100)
first(samples(10, 0.5), 5)
```
n=10、θ=0.5で５個yを生成した結果は[3,4,6,6,4]となった。次に$\Pr\left(\left|\frac{y}{n} - \theta\right| > \varepsilon \, \Big| \, \theta\right)$を実装する。
```!
function Pr(n, θ)
    samples_nθ=samples(n, θ)
    count(abs.(samples_nθ ./ n .- θ) .> ε) / length(samples_nθ)
end
Pr(10, 0.5)
```
samples_nθがyであり、100個生成している。全てのsamples_nθをnで割り、θを引き、絶対値をとっている。
この絶対値がε(ここでは0.1)より大きい個数の100個中の割合が$\Pr\left(\left|\frac{y}{n} - \theta\right| > \varepsilon \, \Big| \, \theta\right)$である。

nを大きくしていってPr(n, θ)の値がどうなるか確認する。
```!
using Plots
Pr(n)=Pr(n, 0.4)
plot(1:10:500, Pr, yrotation=90, label=nothing)
savefig(joinpath(@OUTPUT, "WLLN.svg"))
nothing
```
\fig{WLLN}

nが大きくなるにつれ、$\Pr\left(\left|\frac{y}{n} - \theta\right| > \varepsilon \, \Big| \, \theta\right)$は0に近いている。