@def title = "BDA3の2.11 Exercisesの3を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの3を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 3. Predictive distributions
サイコロを10回振って６が出た回数をyとする。

## (a) yを正規分布で近似する
yは二項分布Binomial(n=1000, p=1/6)に従う。二項分布の平均$μ$はnpであり、分散$σ^2$はnp(1-p)である。
yを正規分布近似すると$\text{Normal}(np,\sqrt{np(1-p)})$となる。
```!
using Distributions, StatsPlots
meany=1000*1/6
stdy=sqrt(1000*1/6*(1-1/6))
nay=Normal(meany,stdy)
plot(nay,label="Normal",yrotation=90)
plot!(Binomial(1000,1/6),label="Binomial(1000,1/6)",xlims=(100,250))
savefig(joinpath(@OUTPUT, "Binomial.svg"))
nothing
```
\fig{Binomial}

二項分布を正規分布でよく近似できていることがわかる。

## (b) 分位数を計算する
分位数はquantileを使って計算する。正規分布近似の分位数は
```!
q = [0.05,0.25,0.5,0.75,0.95]
nayq = quantile(nay, q)
```
となる。二項分布の分位数は
```!
yq = quantile(Binomial(1000,1/6), q)
```
となる。表でまとめると
```!
csv="""分位数,$(join(q,","))
正規分布近似,$(join(round.(nayq;digits=2),","))
二項分布,$(join(yq,","))"""
write(joinpath(@OUTPUT,"quantile.csv"), csv)
nothing
```
\tableinput{}{./code/output/quantile.csv}

となる。二項分布が正規分布で近似できるのは中心極限定理のためである。