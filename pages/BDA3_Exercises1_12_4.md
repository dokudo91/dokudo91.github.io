@def title = "BDA3の1.12 Exercisesの4を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の1.12 Exercisesの4を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 4. Probability assignment
フットボールの試合で８点差のついた試合１２試合を取り出して考える。
その１２試合の収支は-7,-5,-3,-3,1,6,7,13,15,16,20,21である。
プラス収支は優位なチームが勝った時の収支であり、マイナス収支は劣位なチームが勝った時の収支である。

## (a) 条件付き確率の計算
Pr(優位チームの勝利 | 点差=8)は12試合中8試合なので、8/12=0.667である。

Pr(優位チームの収支８以上 | 点差=8)は12試合中5試合なので、5/12=0.417である。

Pr(優位チームの収支８以上 | 点差=8, 優位チームの勝利)は8試合中5試合なので、5/8=0.625である。

## (b) 正規分布近似
収支-点差の分布を正規分布近似する。
```!
using Distributions
dist=fit(Normal,[-7,-5,-3,-3,1,6,7,13,15,16,20,21] .- 8)
```
平均は-1.25、標準偏差は9.67の正規分布に近似された。

Pr(優位チームの勝利 | 点差=8)は
```!
1-cdf(dist,-8)
```
である。

Pr(優位チームの収支８以上 | 点差=8)は
```!
1-cdf(dist,0)
```
である。

Pr(優位チームの収支８以上 | 点差=8, 優位チームの勝利)は
```!
(1-cdf(dist,0))/(1-cdf(dist,-8))
```
である。