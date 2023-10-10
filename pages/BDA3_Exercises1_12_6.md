@def title = "BDA3の1.12 Exercisesの6を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の1.12 Exercisesの6を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 6. Conditional probability
一卵性双生児である確率は1/300である。
二卵性双生児である確率は1/125である。
双生児兄弟が一卵性双生児である確率はどうなるか？

一卵性双生児かつ両方男である確率は
$$
Pr(一卵性双生児, 両方男)=Pr(一卵性双生児)Pr(両方男|一卵性双生児)=\frac{1}{300}\frac{1}{2}
$$
である。二卵性双生児かつ両方男である確率は
$$
Pr(二卵性双生児, 両方男)=Pr(二卵性双生児)Pr(両方男|二卵性双生児)=\frac{1}{125}\frac{1}{4}
$$
である。一卵性双生児であれば性別が異なることはないので、男女の1/2であるが、
二卵性双生児であれば男男の確率は$1/2 \cdot 1/2 = 1/4$である。
双生児兄弟が一卵性双生児である確率は
$$
Pr(一卵性双生児|両方男)=\frac{Pr(一卵性双生児,両方男)}{Pr(両方男)} \\
=\frac{1/2\cdot 1/300}{1/2\cdot 1/300+1/4\cdot 1/125} =\frac{5}{11}
$$
である。