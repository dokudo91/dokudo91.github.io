@def title = "Constructor"
@def tags = ["julia", "Constructor"]
# Constructor
[Constructor](https://docs.julialang.org/en/v1/manual/constructors/)
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
