@def title = "BDA3の2.11 Exercisesの20を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの20を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 20. Censored and uncensored data in the exponential model

## (a) y≥100を観測時の事後分布
y|θは指数分布Exponetial(θ)に従う。θの事前分布はガンマ分布Gamma(α,β)である。
y≥100を観測したとする。この時、θの事後分布θ|yはどうなるか？
y|θの確率密度関数は
$$
p(y|θ)=θe^{-θy}
$$
である。y≥100を観測したら
$$
p(y≥100|θ)=\int^{\infty}_{100}θe^{-θy}dθ
$$
と尤度関数を計算できる。計算すると
$$
p(y≥100|θ)=θ[-\frac{1}{θ}e^{-θy}]^{\infty}_{100} =e^{-100θ}
$$
となる。
θの確率密度関数は
$$
p(θ)∝θ^{α-1}e^{-βθ}
$$
であるので、事後分布θ|yの確率密度関数は
$$
p(θ|y≥100)=e^{-100y}θ^{α-1}e^{-βθ}=θ^{α-1}e^{-(β+100)θ}
$$
である。つまり、θ|y≥100~Gamma(α,β+100)である。平均と分散は
$$
E(θ|y≥100)=\frac{α}{β+100}
$$
$$
Var(θ|y≥100)=\frac{α}{(β+100)^2}
$$
となる。

## (b) y=100を観測時の事後分布
y=100の時の尤度関数は
$$
p(y=100|θ)=θe^{-100θ}
$$
となる。事後分布θ|yの確率密度関数は
$$
p(θ|y=100)=θe^{-100y}θ^{α-1}e^{-βθ}=θ^{α+1-1}e^{-(β+100)θ}
$$
となる。つまり、θ|y=100~Gamma(α+1,β+100)である。平均と分散は
$$
E(θ|y=100)=\frac{α+1}{β+100}
$$
$$
Var(θ|y=100)=\frac{α+1}{(β+100)^2}
$$
となる。

## (c) y≥100とy=100の時の分散の比較
$Var(θ|y≥100)=\frac{α}{(β+100)^2}$と$Var(θ|y=100)=\frac{α+1}{(β+100)^2}$となっており、
y=100を観測した時の方がθの事後分布の分散は大きくなっている。
y=100の方がyに関して情報が多いので、この結果は直感に反している。
この結果から言えることはyに関する厳密性はθの厳密性と無関係であるということである。