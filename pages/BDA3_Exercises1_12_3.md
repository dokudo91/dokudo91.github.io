@def title = "BDA3の1.12 Exercisesの3を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の1.12 Exercisesの3を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 3. Probability calculation for genetics
目の色を決定する遺伝子Xxがある。xxであれば、青い目となり、それ以外の組み合わせでは茶色の目となる。
xX、Xxをヘテロ接合という。xを持つ確率はpである。
よってxxを持つ可能性は$p^2$、ヘテロ接合している確率は$2p(1-p)$、XXである確率は$(1-p)^2$である。

## ヘテロ接合である確率
両親が茶色の目を持ち、自身も茶色の目を持つ子供がヘテロ結合である確率はどうなるか？
出したい確率はp(子供がヘテロ接合|両親が茶色の目, 子供が茶色の目)である。
A=子供がヘテロ接合, B=両親が茶色の目, C=子供が茶色の目とすると、
ベイズの定理より
$$
p(A|B, C) =\frac{p(B, C|A)p(A)}{p(B, C)}
$$
p(B, C|A)は子供がヘテロ接合の時、子供と両親の目が茶色である確率である。
両親の遺伝子としては(XX, XX)、(XX, ヘテロ接合)、(ヘテロ接合, ヘテロ接合)の３パターンがある。
(XX, XX)の確率は$(1-p)^4$、(XX, ヘテロ接合)の確率は$2(1-p)^2 2p(1-p)$、(ヘテロ接合, ヘテロ接合)の確率は$(2p(1-p))^2$である。
それぞれのp(A)は$0, \frac{1}{2}, (\frac{1}{2})^2\cdot 2$である。
よって
$$
p(B, C|A)p(A)=(1-p)^4 0+2(1-p)^2 2p(1-p)\frac{1}{2}+(2p(1-p))^2(\frac{1}{2})^2\cdot 2 \\
=2p(1-p)^3+2p^2(1-p)^2
$$
p(B,C)は子供がヘテロ接合であるという条件がないので、XXの場合も考える。
$$
p(B,C)=(1-p)^4+2(1-p)^2 2p(1-p)+(2p(1-p))^2\frac{3}{4} \\
=(1-p)^4+4p(1-p)^3+3p^2(1-p)^2
$$
(1),(2),(3)式から
$$
p(A|B, C)=\frac{2p(1-p)^3+2p^2(1-p)^2}{(1-p)^4+4p(1-p)^3+3p^2(1-p)^2} \\
=\frac{2p}{1+2p}
$$
となる。