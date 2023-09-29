@def title = "BDA3の2.11 Exercisesの4を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの4を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 4. Predictive distributions
6が出る確率が1/6でないサイコロを1000回振る。6が出る確率θの事前分布は
$$
Pr(θ = 1/12) = 0.25 \\
Pr(θ = 1/6) = 0.5 \\
Pr(θ = 1/4) = 0.25
$$
と考えている。yは二項分布Binomial(1000,θ)である。
この正規分布近似は$\text{Normal}(1000θ,\sqrt{1000θ(1-θ)})$である。

## (a) 条件付き確率分布p(y|θ)をスケッチする
```!
using Distributions, StatsPlots
conditional_y(θ)=Normal(1000*θ,sqrt(1000*θ*(1-θ)))
plot(conditional_y(1//12),label="θ=1/12",yrotation=90)
plot!(conditional_y(1//6),label="θ=1/6")
plot!(conditional_y(1//4),label="θ=1/4")
savefig(joinpath(@OUTPUT, "conditional_y.svg"))
nothing
```
\fig{conditional_y}

## (b) yの分位数を求める
p(y)は
$$
p(y)=Pr(θ = 1/12)p(y|θ=1/12)+Pr(θ = 1/6)p(y|θ=1/6)+Pr(θ = 1/4)p(y|θ=1/4)
$$
で計算できる。
```!
py(y)=0.25pdf(conditional_y(1//12),y)+0.5pdf(conditional_y(1//6),y)+0.25pdf(conditional_y(1//4),y)
plot(0:400,py,yrotation=90,label="p(y)")
plot!(conditional_y(1//12),label="p(y|θ=1/12)")
plot!(conditional_y(1//6),label="p(y|θ=1/6)")
plot!(conditional_y(1//4),label="p(y|θ=1/4)")
savefig(joinpath(@OUTPUT, "py.svg"))
nothing
```
\fig{py}

分位数を求める関数はquantileがあるがこれはヒストグラムに対して使えるのであり、PDFに対して使うことはできない。
p(y)は確率密度であり、全範囲で積分すると1になる。0.05分位数とはつまり、下端から積分して0.05になる点のことである。
yの範囲は[1,1000]なので、1から順に足していったものが積分値である。
```!
cumsum([py(y) for y in 1:1000])[1:100:400]
```
cumsumはインデックスの1から順に足していき、その場所まで足した値の配列を返す。
1ではほぼ0であり、100で0.245、200で0.749、300まで足した時点でほぼ1になっている。
これを使い、PDF用のquantile関数を作る。
```!
function fquantile(py,yvalues,q)
    index=findfirst(≥(q),cumsum([py(y) for y in yvalues]))
    getindex(yvalues,index)
end
yq=fquantile.(py, Ref(1:1000), [.05, .25, .5, .75, .95])
csv="""分位数,$(join([.05, .25, .5, .75, .95],","))
正規分布近似,$(join(yq,","))"""
write(joinpath(@OUTPUT,"quantile.csv"), csv)
nothing
```
\tableinput{}{./code/output/quantile.csv}