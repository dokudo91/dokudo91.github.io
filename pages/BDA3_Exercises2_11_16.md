@def title = "BDA3の2.11 Exercisesの16を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの16を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 16. Beta-binomial distribution and Bayes’ prior distribution
yは二項分布Binomial(n, θ)に従う。θの事前分布をBeta(α, β)とする。

## (a) 周辺分布p(y)
周辺分布p(y)は
$$
p(y)=\int^1_0p(y|θ)p(θ)dθ
$$
で計算できる。
$$
p(y)=\int^1_0\binom{n}{y}θ^y(1-θ)^{n-y}\frac{θ^{α-1}(1-θ)^{β-1}}{B(α,β)}dθ \\
=\frac{Γ(n+1)}{Γ(y+1)Γ(n-y+1)}\frac{Γ(y+α)Γ(n-y+β)}{Γ(n+α+β)}\frac{Γ(α+β)}{Γ(α)Γ(β)}
$$

## (b) 周辺分布p(y)が一定になる条件
p(y)がyに依存しないとき、一定になる。α=β=1を(2)入れると、
$$
p(y)=\frac{Γ(n+1)}{Γ(y+1)Γ(n-y+1)}\frac{Γ(y+1)Γ(n-y+1)}{Γ(n+2)}\frac{Γ(2)}{Γ(1)Γ(1)} \\
=\frac{Γ(n+1)}{Γ(y+1)Γ(n-y+1)}\frac{Γ(y+1)Γ(n-y+1)}{(n+1)Γ(n+1)} \\
=\frac{1}{n+1}
$$
となる。