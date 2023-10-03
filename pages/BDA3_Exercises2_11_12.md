@def title = "BDA3の2.11 Exercisesの12を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの12を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 12. Jeffreys’ prior distributions
$y|θ \sim \mathrm{Poisson(θ)}$とする。

## ジェフェリーズ事前分布
θに対するジェフェリーズ事前分布を探す。ジェフェリーズ事前分布は無情報事前分布である。
無情報事前分布は事前分布に確固とした信念がない場合、妥当な選択肢である。
ジェフェリーズ事前分布の確率密度は
$$
p(θ) ∝ \sqrt{J(θ)}
$$
である。J(θ)はフィッシャー情報であり、
$$
J(θ)=E((\frac{d\mathrm{log}p(y|θ)}{dθ})^2|θ)=-E(\frac{d^2\mathrm{log}p(y|θ)}{dθ^2}|θ)
$$
である。$y|θ \sim \mathrm{Poisson(θ)}$なのでその確率密度は
$$
p(y|θ)=\frac{e^{-θ}θ^y}{y!}
$$
である。
$$
\mathrm{log}(p(y|θ))=-θ+y\mathrm{log}(θ)-\mathrm{log}(y!)
$$
$$
\frac{d}{dθ}(\mathrm{log}(p(y|θ)))=-1+\frac{y}{θ}
$$
$$
\frac{d^2}{dθ^2}(\mathrm{log}(p(y|θ)))=-\frac{y}{θ^2}
$$
$$
J(θ)=E(\frac{y}{θ^2}|θ) \\
=\frac{1}{θ^2}E(y|θ)
$$
$y|θ \sim \mathrm{Poisson(θ)}$から$E(y|θ)=θ$、よって
$$
J(θ)=\frac{1}{θ}
$$
ジェフェリーズ事前分布p(θ)は
$$
p(θ)=\sqrt{J(θ)}=θ^{-\frac{1}{2}}
$$
である。

## ガンマ分布との近似
ガンマ分布Gamma(α,β)の確率密度は
$$
p(θ)∝θ^{α-1}e^{-βθ}
$$
であるので、ジェフェリーズ事前分布p(θ)はGamma(α=1/2, β=0)的な形の分布になっている。
実際はβ=0でガンマ分布は定義されないが共役事前分布として事後分布の解析に利用できる。