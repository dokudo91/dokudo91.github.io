@def title = "確率分布フィッティング"
@def tags = ["julia", "確率分布フィッティング"]
@def description = "Juliaで確率分布フィッティングを行う。"

# 確率分布フィッティング
実際のデータに近い確率分布を探したい。データは[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)の[Football scores and point spreads](http://www.stat.columbia.edu/~gelman/book/data/football.asc)を使う。
```!
using CSV, DataFrames, StatsPlots
df = CSV.File("_assets/datasets/football.csv", delim = ' ', ignorerepeated = true, header=true) |> DataFrame
first(df, 5)
```
ここで、favoriteは勝つと予想されているチームの実際の点数、underdogは負けると予想されているチームの実際の点数、spreadはその試合の点差予想である。
```!
outcomes = df.favorite .- df.underdog
first(outcomes, 5)
```
outcomesに実際の点数差を計算する。実際の点数差と予想の点数差との差をヒストグラムにする。
```!
histogram(outcomes - df.spread, label="outcome - point spread")
savefig(joinpath(@OUTPUT, "football.png"))
nothing
```
\fig{football}

このヒストグラムを正規分布にフィッティングする。
```!
using Distributions
fitted = fit(Normal, outcomes - df.spread)
```
平均は0.23で標準偏差は13.69の正規分布にフィッティングされた。
```!
histogram(outcomes - df.spread, normalize=:pdf, label="outcome - point spread")
plot!(fitted, label="Normal PDF")
savefig(joinpath(@OUTPUT, "football_fitted.png"))
nothing
```
\fig{football_fitted}

ここで、ヒストグラムは`normalize=:pdf`でPDFに正規化している。
正規分布の標準偏差が13.69ということは平均0.23から±13.69内に約68%のデータが含まれることを意味する。