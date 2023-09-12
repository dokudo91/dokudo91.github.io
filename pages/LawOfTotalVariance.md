@def title = "Law of total varianceをJuliaで検証する"
@def tags = ["julia", "Law of total variance"]
@def description = "Law of total varianceを男女の身長の分布を例に確認した。"
{{fill description}}
# Law of total variance
Law of total varianceは以下の式である。
$$
Var(Y)=Var(E[Y∣X])+E[Var(Y∣X)]
$$

## 具体例： 男女の身長の分布
Xは0から1の一様分布。Yは男女合わせた身長とする。
男の身長は平均170、標準偏差10の正規分布に従うとし、女の身長は平均160、標準偏差5の正規分布に従うとする。
Yの分布は男の分布と女の分布を6:4で混ぜ合わせた分布とする。サンプルは0≤X<0.6であれば男の分布に0.6≤X≤1であれば女の分布に属するとする。
```!
using Distributions, StatsPlots
μm = 170
σm = 10
μf = 160
σf = 5

dist_male = Normal(μm, σm)
dist_female = Normal(μf, σf)

Y = MixtureModel([dist_male, dist_female], [0.6, 0.4])
plot(Y, label=["male PDF" "female PDF"])
plot!(x->pdf(Y,x), label="Mixture PDF")
savefig(joinpath(@OUTPUT, "LawOfTotalVariance.svg"))
nothing
```
\fig{LawOfTotalVariance}

Distributionsパッケージを使って混合モデルを作っている。この混合モデルの分散をLaw of total varianceで計算する。
Yから取り出したサンプルは0.6の確率でμm=170の、0.4の確率でμf=160の分布の分布に含まれる。Yから取り出したサンプルの平均の分散Var(E[Y])は
```!
Var_E_Y = [(μm - mean(Y))^2, (μf - mean(Y))^2]
```
0.6の確率で16、0.4の確率で36となる。従って
```!
Var_E_Y_given_X = 0.6 * Var_E_Y[1] + 0.4 * Var_E_Y[2]
```
$Var(E[Y|X])=24$となる。Yの分散は
```!
Var_Y=[σm^2, σf^2]
```
0.6の確率で100であり、0.4の確率で25である。その期待値は
```!
E_Var_Y_given_X = 0.6 * Var_Y[1] + 0.4 * Var_Y[2]
```
$E[Var(Y|X)]=70$となる。
Law of total varianceより
$$
Var(Y)=Var(E[Y∣X])+E[Var(Y∣X)]=24+70=94
$$
MixtureModelは直接、分散を計算できるので値を確認する。
```!
var(Y)
```
同じ値になっていることが確認できた。