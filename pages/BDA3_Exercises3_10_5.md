@def title = "BDA3の3.10 Exercisesの4を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の3.10 Exercisesの4を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 5. Rounded data
工場で5つの製品の重さを測った。
その値は四捨五入して、y=[10, 10, 12, 11, 9]だった。
四捨五入しない本当の重さは正規分布$N(μ,σ^2)$に従っているとする。
$μ,σ^2$の事前分布は無情報事前分布とする。

## (a) yが正確な値だった場合
y=[10, 10, 12, 11, 9]と実際に観測されたとする。
本文p.65より
$$
µ|σ^2, y \sim N(y, σ^2/n).
$$
$$
σ^2|y \sim \text{Inv-}χ^2(n − 1, s^2)
$$
である。ここで$s^2$はサンプル分散である。
```!
using Distributions, StatsPlots
y=[10, 10, 12, 11, 9]
posterior_variance_a_dist = InverseGamma((length(y)-1)//2, 1//2) * std(y)
plot(posterior_variance_a_dist, label="posterior variance", yrotation=90, xlim=(0,4))
savefig(joinpath(@OUTPUT, "posterior_variance_a_dist.svg"))
nothing
```
\fig{posterior_variance_a_dist}

図は$σ^2|y \sim \text{Inv-}χ^2(n − 1, s^2)$の確率密度関数である。
この時、μの事後分布は以下のようになる。
```!
posterior_variance_a = rand(posterior_variance_a_dist, 10)
posterior_mean_a_dist = Normal.(mean(y),posterior_variance_a)
plot(posterior_mean_a_dist, yrotation=90)
savefig(joinpath(@OUTPUT, "posterior_mean_a_dist.svg"))
posterior_variance_a
```
この値は分散の事後分布から得られた値である。
\fig{posterior_mean_a_dist}

## (b) yが四捨五入した値だった場合
μとσの事後分布は
$$
p(μ,σ^2|y)∝p(μ,σ^2)p(y|μ,σ^2)
$$
である。事前分布p(μ,σ^2)は無情報事前分布なので
$$
p(μ,σ^2)=σ^{-2}
$$
である。

yが10の時、考えうる値は9.5≤y<10.5である。
yは正規分布に従っているので、この範囲内に入る確率は
$$
p(y|μ,σ^2)∝Φ(\frac{y_i+0.5-μ}{σ})-Φ(\frac{y_i-0.5-μ}{σ})
$$
である。yがn個観測された場合は全てをかけて
$$
p(y|μ,σ^2)∝\prod^n_{i=1}(Φ(\frac{y_i+0.5-μ}{σ})-Φ(\frac{y_i-0.5-μ}{σ}))
$$
となる。
(3),(4),(6)式より
$$
p(μ,σ^2|y)∝σ^{-2}\prod^n_{i=1}(Φ(\frac{y_i+0.5-μ}{σ})-Φ(\frac{y_i-0.5-μ}{σ}))
$$

# (c) (a)と(b)の分布の比較
横軸μ、縦軸logσの等高線で確率密度の分布を確認する。
縦軸はlogσなので、事前分布は$p(μ,\log{σ^2})∝1$となる。
計算はグリッド近似を用いて行う。
```!
log_likelihood_a(y,μ,σ)=sum(logpdf.(Normal(μ,σ),y))
function likelihood_matrix_a(y,μ_range,logσ_range)
    m = log_likelihood_a.(Ref(y),μ_range',exp.(logσ_range))
    exp.(m .- maximum(m))
end
μ_range=0:5//100:20
logσ_range=-2:5//100:3
contour_levels=[.0001; .001; .01; .05:.05:.95;]
matrix_a=likelihood_matrix_a(y,μ_range,logσ_range)
contour(μ_range, logσ_range, matrix_a, levels=contour_levels, title="Probability Distribution (a)")
savefig(joinpath(@OUTPUT, "contour_a.svg"))
nothing
```

```!
function log_likelihood_b(y,μ,σ)
    normaldist=Normal(μ,σ)
    sum(log.(cdf(normaldist, y .+ 0.5) .- cdf(normaldist, y .- 0.5)))
end
function likelihood_matrix_b(y,μ_range,logσ_range)
    m = log_likelihood_b.(Ref(y),μ_range',exp.(logσ_range))
    exp.(m .- maximum(m))
end
matrix_b=likelihood_matrix_b(y,μ_range,logσ_range)
contour(μ_range, logσ_range, matrix_b, levels=contour_levels, title="Probability Distribution (b)")
savefig(joinpath(@OUTPUT, "contour_b.svg"))
nothing
```
\fig{contour_a}
\fig{contour_b}

この図は横軸μ、縦軸logσの確率密度の等高線である。
(a)と(b)を比較すると、(b)の方が分散が小さい方向に確率密度が傾いていることがわかる。

統計量も確認する。
```!
using StatsBase
μ_weight_a = sum(matrix_a,dims=1)|>vec
μ_quantile_a=wquantile(μ_range,μ_weight_a,[.025,.975])
σ_weight_a = sum(matrix_a,dims=2)|>vec
σ_quantile_a=wquantile(exp.(logσ_range),σ_weight_a,[.025,.975])

μ_weight_b = sum(matrix_b,dims=1)|>vec
μ_quantile_b=wquantile(μ_range,μ_weight_b,[.025,.975])
σ_weight_b = sum(matrix_b,dims=2)|>vec
σ_quantile_b=wquantile(exp.(logσ_range),σ_weight_b,[.025,.975])

csv="""分位数,0.025,0.975
(a) μ,$(join(round.(μ_quantile_a;digits=2),","))
(b) μ,$(join(round.(μ_quantile_b;digits=2),","))
(a) σ,$(join(round.(σ_quantile_a;digits=2),","))
(b) σ,$(join(round.(σ_quantile_b;digits=2),","))"""
write(joinpath(@OUTPUT,"quantile.csv"), csv)
nothing
```
\tableinput{}{./code/output/quantile.csv}

平均は四捨五入を考慮した場合としない場合で大きな変化はないが、
標準偏差は四捨五入を考慮した場合の方が小さくなっている。

## (d) 四捨五入されていない実際の値
四捨五入されていない実際の値をzとする。
5つの観測値yに対して、それぞれzが求められる。
μとσに関してグリッド近似しているので、そのグリッドをタプル(μ, σ)のマトリックスで作成する。
```!
μσ_matrix = tuple.(μ_range, exp.(logσ_range)')
μσ_matrix[1:3,1:3]
```
```!
μσ_sample = wsample(μσ_matrix, matrix_b'|>vec)
```
matrix_b'はμσ_matrixに対応する確率密度である。
これを重み付きサンプリングすることで、確率密度を考慮してμとσの組み合わせを選ぶことができる。
これを元に正規分布を作成する。
```!
Normal(μσ_sample...)
```
z作成関数を定義する。
```!
function z(normal_dists, yi)
    n=length(normal_dists)
    lowers = cdf.(normal_dists, yi-0.5)
    uppers = cdf.(normal_dists, yi+0.5)
    quantile.(normal_dists, lowers .+ rand(n) .* (uppers .- lowers))
end
z([Normal(μσ_sample...)], 10)
```
10の観測値に対して、四捨五入する前の値が出力されている。
μσ_matrixから5000サンプリングして、5つの観測値yに対応するzをそれぞれ5000個出力する。
```!
μσ_samples = wsample(μσ_matrix,matrix_b'|>vec,5000)
normal_dists = [Normal(s...) for s in μσ_samples]
zs = z.(normal_dists|>Ref, y)
histogram(zs[1])
savefig(joinpath(@OUTPUT, "histogram.svg"))
nothing
```
\fig{histogram}

正規分布のμが10.4付近にあると考えているので、一様分布にはなっていない。
$(z_1-z_2)^2$の平均を計算すると
```!
mean(abs2, (zs[1] .- zs[2]))
```
となる。