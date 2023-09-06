@def title = "ベイズ推定"
@def tags = ["julia", "ベイズ推定"]
@def description = "Juliaでベイズ推定を扱う。"

# ベイズ推定
{{fill description}}
推定を行いたいパラメータをθ、観測データをyとするとθとyの同時確率分布は
$$
p(θ, y) = p(θ)p(y|θ)
$$
で表される。
$p(θ)$はθの事前分布の確率密度関数であり、推定者の事前のθに対する信念を反映する。
$p(y|θ)$は尤度関数であり、特定の値θが与えられたとき、観測データyの確率密度関数(PDF)である。
$p(θ, y)$はθとyが同時に特定の値をとる同時確率分布の確率密度関数である。

## 事後確率
事後確率は
$$
p(θ|y) = \frac{p(θ, y)}{p(y)} = \frac{p(y|θ)p(θ)}{p(y)}
$$
である。$p(y)$は周辺尤度であり、$p(y) = ∫ p(θ, y) dθ$である。

## 具体例：コイントス
コイントスを例にベイズ推定を行う。コインは歪んでおり、表が出る確率は全くわからない。そしてこのコインの表が出る確率θをベイズ推定したい。
### 事前確率 p(θ)
表が出る確率は0から1でフラットに考えているので、コインの表が出る確率の事前確率は0から1の一様分布とする。
```julia:bayes/ex1
using Distributions, StatsPlots
prior_distribution = Uniform(0,1)

plot(prior_distribution, xlims=(-0.1,1.1), ylims=(0,1.5), label="PDF", ylabel="#")
savefig(joinpath(@OUTPUT, "prior_distribution.svg"))
@show pdf(prior_distribution, 0.1) # p(θ=0.1) = 1
```
\fig{bayes/prior_distribution}
\output{bayes/ex1}
### 尤度関数 p(y|θ)
コイントスを10回行い、表が出た回数yを測定する。
表が出る確率がθで、コイントスを10回行った時に表が出る確率分布は二項分布`Binomial(10, θ)`で表される。
θは確率変数なのでθを変数とした関数を定義する。
```julia:bayes/ex1
sampling_distribution(θ) = Binomial(10, θ)

plot(sampling_distribution(0.1), xticks=0:1:10, label="PMF", ylabel="#")
savefig(joinpath(@OUTPUT, "sampling_distribution.svg"))
@show pdf(sampling_distribution(0.1), 3) # p(y=3|θ=0.1)
```
θ=0.1の時の確率質量関数(PMF)のグラフは以下のようになる。
\fig{bayes/sampling_distribution}

θ=0.1の時にy=3となる確率は
\output{bayes/ex1}
である。
### 同時確率 p(θ, y)=p(θ)p(y∣θ)
同時確率は
```julia:bayes/ex1
joint_probability(θ, y) = pdf(prior_distribution, θ) * pdf(sampling_distribution(θ), y) # p(θ, y) = p(θ)p(y∣θ)
@show joint_probability(0.1, 3) # p(θ=0.1, y=3)
@show joint_probability(0.3, 3) # p(θ=0.3, y=3)
```
となる。
\output{bayes/ex1}

コイントスを10回して表が3回出たとすると、そのコインの表が出る確率θが0.1である確率密度は0.057であり、θが0.3である確率密度は0.267である。

```julia:bayes/ex1
joint_probabilities=[joint_probability(θ,3) for θ in 0:0.01:1]
plot(0:0.01:1, joint_probabilities, label="PDF", ylabel="#")
savefig(joinpath(@OUTPUT, "joint_probabilities.svg"))
@show (argmax(joint_probabilities) - 1) * 0.01
```
y=3の時のθの確率分布は以下のようになる。
\fig{bayes/joint_probabilities}

最大値をとるインデックスはargmaxで取得できる。
\output{bayes/ex1}
PDFはθ=0.3の時に最大となっている。
### 周辺確率 p(y)=∫p(θ,y)dθ
周辺確率は同時確率をθで積分することで計算できる。
```julia:bayes/ex1
marginal_likelihood(y)=sum(joint_probability(θ,y)*0.01 for θ in 0:0.01:1)
@show marginal_likelihood(1)
@show marginal_likelihood(3)
@show marginal_likelihood(5)
```
\output{bayes/ex1}
事前確率が一様分布なので周辺確率に違いはない。
### 事後確率 p(θ|y)=p(θ,y)/p(y)
事後確率は
```julia:bayes/ex1
posterior_probability(θ,y)=joint_probability(θ,y)/marginal_likelihood(y)
```
となる。その確率分布は
```julia:bayes/ex1
posterior_density=[posterior_probability(θ,3) for θ in 0:0.01:1]
plot(0:0.01:1, posterior_density, label="PDF", ylabel="#")
savefig(joinpath(@OUTPUT, "posterior_density.svg"))
```
\fig{bayes/posterior_density}

となる。コインの表が出る確率θに対して、0%から100%まで一様分布していた信念が、コイントスを10回して表が3回出たため、このような確率分布に更新された。

この確率分布を積分した値は正しく1になっている。
```julia:bayes/ex1
@show sum(posterior_density * 0.01)
```
\output{bayes/ex1}
Juliaはブロードキャスティングを言語仕様でサポートしているので、`posterior_density * 0.01`は配列posterior_densityの全ての要素に0.01を掛ける操作となる。