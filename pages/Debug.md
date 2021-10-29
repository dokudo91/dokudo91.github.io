@def title = "デバッグ"
@def tags = ["julia", "Debug"]
@def description = "Visual Studio Code、REPLを用いたデバッグテクニック。"

# デバッグ
{{fill description}}
\toc

## 外部ライブラリのコードを確認する
[edit](https://docs.julialang.org/en/v1/stdlib/InteractiveUtils/#InteractiveUtils.edit-Tuple{AbstractString,%20Integer})
関数にModuleを渡せばエディタでそのソースコードを開く。
[DataFrames](https://github.com/JuliaData/DataFrames.jl)であれば、
```julia-repl
julia> edit(DataFrames)
```
とすればよい。
エディタは環境変数で指定する事ができる。
環境変数は"~/.julia/config/startup.jl"で編集する。
```
ENV["JULIA_EDITOR"]="code"
```
を追加すれば、エディタをVisual Studio Codeに変更する事ができる。

## Visual Studio CodeのREPLからデバッグする
```julia-repl
julia> @enter println("aaa")
```
でprintlnのデバッグ実行を開始する事ができる。