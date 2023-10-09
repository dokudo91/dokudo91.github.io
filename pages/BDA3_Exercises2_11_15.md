@def title = "BDA3の2.11 Exercisesの15を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの15を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 15. Beta distribution
Z ~ Beta(α, β)とする。確率密度関数は
$$
p(u)=\frac{u^{α-1}(1-u)^{β-1}}{B(α,β)}
$$
である。ここでベータ関数B(α,β)は
$$
B(α,β)=\frac{Γ(α)Γ(β)}{Γ(α+β)}
$$
と定義されている。

## $E[Z^m(1-Z)^n]$を計算する
$$
E[Z^m(1-Z)^n]=\int^1_0u^m(1-u)^n\frac{u^{α-1}(1-u)^{β-1}}{B(α,β)}du \\
=\frac{Γ(α+β)}{Γ(α)Γ(β)}\int^1_0u^{m+α-1}(1-u)^{n+β-1}du \\
=\frac{Γ(α+β)}{Γ(α)Γ(β)}\frac{Γ(α+m)Γ(β+n)}{Γ(α+β+m+n)}
$$
となる。最後は問題文の式を使った。

## E[Z]を求める
m=1,n=0とする。
$$
E[Z]=\frac{Γ(α+β)}{Γ(α)Γ(β)}\frac{Γ(α+1)Γ(β)}{Γ(α+β+1)} \\
=\frac{Γ(α+β)}{Γ(α)Γ(β)}\frac{αΓ(α)Γ(β)}{(α+β)Γ(α+β)} \\
=\frac{α}{α+β}
$$
Γ(x+1)=xΓ(x)を利用している。

## Var[Z]を求める
$$
Var[Z]=E[Z^2]-(E[Z])^2
$$
の関係式を使う。
m=2,n=0とする。
$$
E[Z]=\frac{Γ(α+β)}{Γ(α)Γ(β)}\frac{Γ(α+2)Γ(β)}{Γ(α+β+2)} \\
=\frac{Γ(α+β)}{Γ(α)Γ(β)}\frac{α(α+1)Γ(α)Γ(β)}{(α+β+1)(α+β)Γ(α+β)} \\
=\frac{α(α+1)}{(α+β+1)(α+β)}
$$
(4)と(6)を(5)に代入する。
$$
Var[Z]=\frac{α(α+1)}{(α+β+1)(α+β)}-\frac{α^2}{(α+β)^2} \\
=\frac{αβ}{(α+β+1)(α+β)^2}
$$