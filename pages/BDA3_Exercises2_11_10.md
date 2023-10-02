@def title = "BDA3の2.11 Exercisesの10を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の2.11 Exercisesの10を解く。"
{{fill description}}
リンクは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。

# 10. Discrete sample spaces
N個のケーブルカーがある。ケーブルカーは連番は付けられており、たまたま見たケーブルカーが203番だった。
この状況でNを推定したい。

## (a) 幾何分布をNの事前分布にする
Nの事前分布が幾何分布に従うとする。また、E(N)=100とする。
幾何分布のPMFは
$$
Pr(X=k)=(1-p)^{k-1}p
$$
である。意味としては当たり確率pのくじをk回目で当たりを引く確率である。
$$
E(X)=\frac{1}{p}
$$
であるので、$p=\frac{1}{100}$である。結局、事前分布のPMFは
$$
p(N)=\frac{1}{100}(\frac{99}{100})^{N-1}
$$
と表される。事後分布は
$$
p(N|y)=\frac{p(y|N)p(N)}{p(y)}
$$
で計算できる。yは特定の番号を見るイベントである。
尤度関数p(y|N)はN<yの時は最大数より大きい番号を見ることはないので
$$
p(y|N)=0
$$
N≤yの時は等確率なので
$$
p(y|N)=\frac{1}{N}
$$
である。周辺分布p(y)は
$$
p(y)=\sum^{\infty}_{N=1}p(y|N)p(N)
$$
であるが、これは∞が含まれるため計算が難しい。

### Juliaで確認
```!
using Distributions, StatsPlots
gprior_dist=Geometric(1/100)
plot(gprior_dist,label="prior",yrotation=90)
savefig(joinpath(@OUTPUT, "gprior.svg"))
nothing
```
\fig{gprior}

事前分布はNが大きくなるに従い可能性が低くなる。

```!
likelihood(y,N)=ifelse(N<y,0,1/N)
plot(1:1000,N->likelihood(203,N),label="likelihood",yrotation=90)
savefig(joinpath(@OUTPUT, "likelihood.svg"))
nothing
```
\fig{likelihood}

尤度関数は203までは0でその点で最大値を取り、徐々に0になる。

```!
marginal(y,summax,prior)=sum(prior(N)*likelihood(y,N) for N in 1:summax)
plot(1:2000,summax->marginal(203,summax,x->pdf(gprior_dist,x)),label="marginal",yrotation=90)
savefig(joinpath(@OUTPUT, "marginal.svg"))
nothing
```
\fig{marginal}

周辺分布はNを∞まで足す必要がある。プログラム的には計算不可能なので、summaxを増やして収束の様子を確認した。
summaxは1000あれば十分と判断する。

```!
posterior(N,y,prior)=prior(N)*likelihood(y,N)/marginal(y,1000,prior)
plot(1:1000,N->posterior(N,203,x->pdf(gprior_dist,x)),label="posterior",yrotation=90)
plot!(1:1000,N->likelihood(203,N),label="likelihood")
savefig(joinpath(@OUTPUT, "posterior.svg"))
nothing
```
\fig{posterior}

事後分布は203まで0でその点で最大値を取り、その後0になる。
尤度関数と比較すると急速に0になるが、これは事前分布の影響が大きい。

## (b) 事後分布の平均と標準偏差
```!
m=sum(posterior(N,203,x->pdf(gprior_dist,x))*N for N in 1:1000)
```
平均は279個である。
```!
sum((m-N)^2*posterior(N,203,x->pdf(gprior_dist,x)) for N in 1:1000)|>sqrt
```
標準偏差は79.6である。

## (c) 事前分布の妥当性
この問題で事前分布としてGeometic(1/100)はあまり妥当ではない。
N=1が最も可能性が高いと考えているし、その平均も100である。
y=203である時点で事前分布としては微妙である。

では、どのような事前分布がいいかというと難しい。
事前分布に強い信念がない時、無情報事前分布が妥当な選択肢である可能性がある。
例えばp(N)=1/1000はどうだろうか？これは全範囲で積分すると無限大となるので確率分布としては不適である。
だが、無情報事前分布は確率分布として不適であっても、事後分布が解析可能であれば、採用可能である。
ここではp(N)=1/1000*1/Nを採用する。
これはまだ確率分布としては不適であるが、1/Nが周辺分布の無限和の計算で有利に働く。
```!
noninfo_prior(N)=1/1000/N
plot(1:1000,N->posterior(N,203,noninfo_prior),label="noninfo_posterior",yrotation=90)
savefig(joinpath(@OUTPUT, "noninfo_posterior.svg"))
nothing
```
\fig{noninfo_posterior}

幾何分布を用いた場合と比べて、0に近づく速度が緩やかになって、尤度関数に近い形になっている。

```!
noninfo_m=sum(posterior(N,203,noninfo_prior)*N for N in 1:1000)
```
平均は406個である。
```!
sum((noninfo_m-N)^2*posterior(N,203,noninfo_prior) for N in 1:1000)|>sqrt
```
標準偏差は195.2である。

幾何分布を用いた場合と比べて、平均は大きく、分散も大きくなっている。
そして、たった1つのケーブルカーの番号を見て全体の数を予測しようとしていることを考えると、
無情報事前分布を用いた結果の方が妥当である。