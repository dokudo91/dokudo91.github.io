@def title = "DataFrames"
@def tags = ["julia", "DataFrames"]
@def description = "DataFramesはpythonにおけるpandasのJulia版。"

# DataFrames
[DataFrames](https://github.com/JuliaData/DataFrames.jl)

{{fill description}}
\toc
## columnをコンソールで省略せずに表示する
showの引数に`allcols=true`を付けることで全てcolumnが表示される。
`allrows=true`をつければ全てのrowが表示される。
```
df = DataFrame(A = 1:4, B = ["M", "F", "F", "M"])
show(df,allcols=true)
```