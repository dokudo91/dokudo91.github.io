@def title = "BDA3の2.11 Exercisesの11を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの11を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 11. Computing with a nonconjugate single-parameter model
y1,...y5はコーシー分布Cauchy(θ,1)からサンプリングされている。
θはコーシー分布の中心である。コーシー分布は平均が定義できないため、中心という言葉を使っている。
yiのPDFは
$$
p(y_i) ∝ \frac{1}{1+(y_i-θ)^2}
$$
である。θの事前分布は一様分布Uniform(0,100)とする。

## コーシー分布
コーシー分布は裾の長い分布である。
例えばコンピューターの反応時間をコーシー分布でモデル化できるかもしれない。
多くの場合は、規定時間内に処理が終わるが、他の処理にリソースを多く割いている場合、
処理が完了する時間が非常に長くなる可能性がある。
低確率で平均から離れたことが起こりうる場合、コーシー分布的である。
```!
using Distributions, StatsPlots
plot(-20:0.1:20,x->pdf(Cauchy(),x),label="Cauchy",yrotation=90)
plot!(Normal(),label="Normal")
savefig(joinpath(@OUTPUT, "Cauchy.svg"))
mean(Cauchy()), var(Cauchy())
```
コーシー分布は平均も分散も定義されない。これは裾が非常に重いためである。
\fig{Cauchy}

正規分布と比較し、裾が長いことがわかる。

## (a) 事後分布の計算
(y1,...y5)=(43,44,45,46.5,47.5)と観測された。事後分布θ|yはどのような分布になるか？

コーシー分布の中心θの事前分布は一様分布Uniform(0,100)である。θ~Uniform(0,100)。
```!
prior_pdf(θ)=pdf(Uniform(0,100),θ)
prior_pdf(10), prior_pdf(85)
```
尤度関数p(y|θ)は観測値が複数ある場合は全て掛け合わせればよい。
$$
p(y|θ)=\prod_i p(y_i|θ)
$$
```!
likelihood_pdf(θ)=prod(pdf.(Cauchy(θ),[43,44,45,46.5,47.5]))
plot(0:0.1:100,x->likelihood_pdf(x),label="likelihood",yticks=nothing)
savefig(joinpath(@OUTPUT, "likelihood.svg"))
nothing
```
\fig{likelihood}

コーシー分布の中心θの事後分布p(θ|y)は
$$
p(θ|y)=\frac{p(y|θ)p(θ)}{\int p(y|θ)p(θ)dθ}
$$
である。
```!
using QuadGK
unnormalized_posterior_pdf(θ)=prior_pdf(θ)*likelihood_pdf(θ)
marginal_pdf,_=quadgk(unnormalized_posterior_pdf,0,100)
posterior_pdf(θ)=unnormalized_posterior_pdf(θ)/marginal_pdf
plot(0:0.1:100,posterior_pdf,yrotation=90,label="posterior")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
```
\fig{posterior}

積分はQuadGKパッケージを使って行った。

## (b) 事後分布のサンプリング
計算した事後分布p(θ|y)から1000個サンプリングを行う。
```!
posteriorθ_samples=wsample(0:0.1:100, posterior_pdf.(0:0.1:100), 1000)
posteriorθ_samples[1:10]
```
サンプリングはMHアルゴリズムでも使った方が良いが、重み付きサンプリング関数wsampleで代用する。
```!
histogram(posteriorθ_samples,yrotation=90,label="posteriorθ_samples",bins=40)
savefig(joinpath(@OUTPUT, "samples.svg"))
nothing
```
\fig{samples}

[43,44,45,46.5,47.5]を観測した後の、コーシー分布の中心θの事後分布のヒストグラムを表示している。

## (c) 予測分布$p(\tilde y|y)$
[43,44,45,46.5,47.5]を観測した後に、今後観測されると予測されるyを$\tilde y|y$とする。
予測分布$p(\tilde y|y)$は
$$
p(\tilde y|y)=\int p(\tilde y|θ)p(θ|y)dθ
$$
で計算できる。
しかし、今回は(b)で作った1000個のサンプルを用いてコーシー分布とフィッテイングを行う。
```!
posterior_y_dist=fit(Cauchy,posteriorθ_samples)
```
中心が45のコーシー分布にfitした。
このコーシー分布を用いて1000個サンプリングを行いヒストグラムで表示する。
```!
using Random
Random.seed!(1)
ysamples=rand(posterior_y_dist,1000)
histogram(ysamples,yrotation=90,label="posterior_y")
savefig(joinpath(@OUTPUT, "posterior_y.svg"))
extrema(ysamples)
```
\fig{posterior_y}

ほとんどは45の周辺であるが、-200から400まで低確率で出現していることがわかる。