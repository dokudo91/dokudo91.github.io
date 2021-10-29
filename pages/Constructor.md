@def title = "コンストラクタ"
@def tags = ["julia", "Constructor"]
@def description = "Juliaは動的型付け言語だが、LLVMコンパイル時は型情報を用いて最適化を行っている。"

# Constructor
[Constructor](https://docs.julialang.org/en/v1/manual/constructors/)

{{fill description}}
従来の動的型付け言語と比べ、型の重要度は大きい。
基本は動的型付け言語的に型を意識せず雑に書いて、速度を気にしたり、パッケージ化する時に型を意識する。
\toc
## 型の初期値を指定する
Juliaにおいて型はstructで定義される。
```julia:./code/ex1
struct Foo
    bar
    baz
end
```
bar, bazの初期値を指定したい場合はOuter Constructorを用いて
```julia:./code/ex1
Foo() = Foo(1,2)
```
とできる。`Foo()`で初期化した`foo`のメンバを確認すると
```julia:./code/ex1
foo = Foo()
@show foo.bar
@show foo.baz
```
\output{./code/ex1}
となっている事が確認できる。
