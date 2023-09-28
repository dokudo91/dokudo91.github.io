@def title = "BDA3の2.11 Exercisesの2を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの2を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 2. Predictive distributions
コインがC1、C2の2枚あり、表が出る確率はそれぞれPr(heads|C1)=0.6、Pr(heads|C2)=0.4である。
どちらか一方のコインを選んでそのコインを投げる。
コインを選ぶ確率は不明である。今、コインを２回投げ、２回とも裏が出た。
この後、コインの表が出るまで何回コインを投げればよいか？その期待値を答えよ。
- C : コインを選ぶイベント
- X : 表が出るまでコインを投げた回数
- TT : 裏が２回出るイベント

## コインC1が選ばれる確率、コインC2が選ばれる確率
コインC1が選ばれる確率を$Pr(C=C1)$とする。$Pr(C=C2)=1-Pr(C=C1)$である。
Cの事前分布は$Pr(C=C1)=Pr(C=C2)=0.5$とする。
裏が２回出た後のCの事後分布は$Pr(C|TT)$である。ベイズの定理より
$$
Pr(C=C1|TT)=\frac{Pr(C=C1)Pr(TT|C=C1)}{Pr(TT)} \\
=\frac{Pr(C=C1)Pr(TT|C=C1)}{Pr(C=C1)Pr(TT|C=C1)+Pr(C=C2)Pr(TT|C=C2)}
$$
で計算できる。$Pr(TT|C=C1)=0.4^2$、$Pr(TT|C=C2)=0.6^2$より
$$
Pr(C=C1|TT)=\frac{0.5 \cdot 0.4^2}{0.5 \cdot 0.4^2+0.5 \cdot 0.6^2}
$$
```!
PrC1TT=0.5*0.4^2/(0.5*0.4^2+0.5*0.6^2)
PrC2TT=1-PrC1TT
PrC1TT, PrC2TT
```
Cの事後分布はPr(C=C1|TT)=0.3077、Pr(C=C2|TT)=0.6923である。

## Xの期待値
Xは幾何分布に従う。幾何分布のPMFは
$$
Pr(X=k)=(1-p)^{k-1} \cdot p
$$
である。k-1回1-pの確率で裏が出て、その後pの確率で表が出る確率を計算している。
この期待値は
$$
E(X)=\Sigma^{\infty}_{k=1}k(1-p)^{k-1}p \\
=\frac{1}{p}
$$
である。

## 裏が２回出た後のXの期待値
裏が２回出た後のXの期待値E(X|TT)はLaw of Total Expectationより
$$
E(X|TT)=E(X|C=C1,TT)Pr(C=C1|TT)+E(X|C=C2,TT)Pr(C=C2|TT)
$$
である。XとTTはCの条件付きで独立なので
$$
E(X|TT)=E(X|C=C1)Pr(C=C1|TT)+E(X|C=C2)Pr(C=C2|TT) \\
=\frac{1}{0.6}\cdot 0.3077 + \frac{1}{0.4}\cdot 0.6923
$$
```!
1/0.6 * PrC1TT + 1/0.4 * PrC2TT
```
裏が２回出た後、表が出るまでにコインを振る回数の期待値は2.24回である。