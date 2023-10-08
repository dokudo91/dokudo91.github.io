@def title = "BDA3の2.11 Exercisesの17を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの17を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 17. Posterior intervals
最高事後信用区間(highest posterior interval)は中央事後信用区間(central posterior interval)と違い、変換に関し不変でない。
$\frac{nν}{σ^2} \sim χ^2_n$とし、σは無情報事前分布$p(σ)∝σ^{-1}$を持つとする。
```!
using Distributions, StatsPlots
plot(Chisq(10),yrotation=90,label="Chisq(10)")
savefig(joinpath(@OUTPUT, "Chisq10.svg"))
nothing
```
\fig{Chisq10}

$χ^2_n$は左右対称でない。

## (a) $σ^2$の事前分布
$u=σ^2$とおくと$σ=\sqrt{u}$である。
$$
p(σ^2)=p(u)
$$
確率密度関数は1対1の変数の変換$φ=h(θ)$に関し
$$
p(φ)=p(θ)|\frac{dθ}{dφ}|=p(θ)|h'(θ)|^{-1}
$$
が成り立つ。今、$θ=\sqrt{u}$、$φ=h(θ)=θ^2=u$とすると、
$$
p(u)=p(\sqrt{u})|\frac{d\sqrt{u}}{du}|=p(\sqrt{u})\frac{1}{2}u^{-\frac{1}{2}}
$$
$u=σ^2$、$σ=\sqrt{u}$なので
$$
p(σ^2)=\frac{1}{2}σ^{-1}p(σ)
$$
σは事前分布として、$p(σ)∝σ^{-1}$であると仮定しているので、
$$
p(σ^2)∝σ^{-1}σ^{-1}=σ^{-2}
$$

## (b) 最高事後信用区間
$χ^2_n$の確率密度関数は
$$
p(y; n) = \frac{y^{n/2 - 1} e^{-y/2}}{2^{n/2} \Gamma(n/2)}, \quad y > 0.
$$
である。$y=\frac{nν}{σ^2}$とすると
$$
p(y|σ)∝(\frac{nν}{σ^2})^{n/2 - 1} e^{-\frac{nν}{2σ^2}} \\
∝(σ^{-2})^{n/2 - 1} e^{-\frac{nν}{2σ^2}} \\
=σ^{-n + 2} e^{-\frac{nν}{2σ^2}}
$$
である。$σ$の事後分布は
$$
p(σ|y)∝p(y|σ)p(σ)∝σ^{-n + 2} e^{-\frac{nν}{2σ^2}}σ^{-1} \\
=σ^{-n + 1} e^{-\frac{nν}{2σ^2}}
$$
$σ^2$の事後分布は
$$
p(σ^2|y)∝p(y|σ^2)p(σ^2)∝σ^{-n + 2} e^{-\frac{nν}{2σ^2}}σ^{-2} \\
=σ^{-n} e^{-\frac{nν}{2σ^2}} \\
=(σ^2)^{-n/2} e^{-\frac{nν}{2σ^2}}
$$
である。$(\sqrt{a},\sqrt{b})$を$σ|y$の95%最高事後信用区間とすると$p(σ=\sqrt{a}|y)=p(σ=\sqrt{b}|y)$となる。
$$
a^{-n/2 + 1/2} e^{-\frac{nν}{2a}}=b^{-n/2 + 1/2} e^{-\frac{nν}{2b}}
$$
$(\sqrt{a},\sqrt{b})$を単純に２乗して変換した$(a,b)$は$σ^2|y$の95%最高事後信用区間となるか？
95%最高事後信用区間であるなら$p(σ^2=a|y)=p(σ^2=b|y)$となるはずである。
$$
(a)^{-n/2} e^{-\frac{nν}{2a}}=(b)^{-n/2} e^{-\frac{nν}{2b}}
$$
(10)を(11)で割ると
$$
a^{1/2}=b^{1/2}
$$
となる。したがってa=bである。
しかし、aとbは信用区間の両端なので、これはあり得ない。
よって、(a,b)は$σ^2|y$の95%最高事後信用区間ではない。