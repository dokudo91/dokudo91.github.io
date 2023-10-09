@def title = "BDA3の1.12 Exercisesの2を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の1.12 Exercisesの2を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 2. Conditional means and variances
## 平均
uがベクトルの時、本文(1.8)のベクトル版
$$
E(\vec{u})=E(E(\vec{u}|v))
$$
を示す。uがベクトルということはE(u)もベクトルである。
$\vec{u}=(u_1,u_2,...,u_n)$であれば$E(\vec{u})=(E(u_1),E(u_2),...,E(u_n))$となる。
証明したいことは全てのベクトル要素に関して$E(u_i)=E(E(u_i|v))$となることである。
$$
E(\vec{u})=\int \vec{\int} \vec{u} \cdot p(\vec{u},v)d\vec{u}dv \\
=\int \vec{\int} \vec{u} \cdot p(\vec{u}|v)d\vec{u}p(v)dv \\
=\int E(\vec{u}|y)p(v)dv \\
=E(E(\vec{u}|v))
$$
p(u,v)もベクトルとなる。$p(\vec{u},v)=(p(u_1,v),p(u_2,v),...,p(u_n,v))$。
## 分散
本文(1.9)のベクトル版も示せる。
$$
\mathrm{var}(\vec{u})=E(\mathrm{var}(\vec{u}|v))+\mathrm{var}(E(\vec{u}|v))
$$