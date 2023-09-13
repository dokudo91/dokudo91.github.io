@def title = "Juliaで確率分布の変換を行う"
@def tags = ["julia", "確率分布"]
@def description = "Juliaで確率分布の変換を行う。"
{{fill description}}

# 確率分布の変換
ある確率分布の確率密度関数を$p_u(u)$とする。この確率変数uをfで変換した確率変数を$v=f(u)$とする。
$p_u$が連続分布で、$v=f(u)$が１対１に対応している時、確率変数vの確率密度関数$p_v(v)$は
$$
p_v(v)=|J|p_u(f^{−1}(v))
$$
となる。ここでJはヤコビアンである。

## Julia code
Juliaで計算結果を確認する。$p_u$を２変量正規分布とする。それぞれ平均0、標準偏差1とする。
uは$(u_1,u_2)$のベクトル、vは$(v_1,v_2)$のベクトルとする。
```!
using Distributions, StatsPlots
pu=MvNormal([0, 0],[1 0; 0 1])
contour(-0.5:0.01:0.5, -0.5:0.01:0.5, (x, y) -> pdf(pu, [x, y]), size=(500, 400))
savefig(joinpath(@OUTPUT, "pu.svg"))
pdf(pu, [0, 0])
```
\fig{pu}

中心点(0,0)がサンプリングされる確率が最も高く、その密度は0.159である。

$v=f(u)=(u_1^3,u_2^3)$とすると、$u=f^{-1}(v)=(v_1^{1/3},v_2^{1/3})$である。
```!
f(u) = u.^3
f_inv(v) = abs.(v).^(1/3) .* sign.(v)
f_inv([-0.5, 0.3])
```
$f^{-1}((-0.5, 0.3))=(-0.794,0.669)$と計算される。
式に含まれるドット(.)はブロードキャスティングであり、配列の全要素に関数操作を広げている。

Jacobianの計算はForwardDiffパッケージを使う。
```!
using ForwardDiff
Jacobian(v)=ForwardDiff.jacobian(f_inv,v)
Jacobian([-0.5, 0.3])
```
$p_v(v)=|J|p_u(f^{−1}(v))$は
```!
using LinearAlgebra
pv(v) = det(Jacobian(v)) * pdf(pu, f_inv(v))
pv([-0.5, 0.3])
```
となる。点v=(-0.5, 0.3)における密度$p_v(v)$は0.0365となる。
確率密度関数のグラフは以下のようになる。0に近づくにつれ密度が無限大に大きくなっている。
これはヤコビアンが無限大に大きくなるためである。
```!
contour(-0.5:0.01:0.5, -0.5:0.01:0.5, (x, y) -> pv([x, y]), size=(500, 400))
savefig(joinpath(@OUTPUT, "pv.svg"))
nothing
```
\fig{pv}