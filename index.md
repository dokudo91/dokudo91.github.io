@def title = "dokudo91のメモ"
@def tags = ["julia", "Franklin"]
\toc
# Julia+Franklinでサイト作成
Juliaと静的サイトジェネレータライブラリ[Franklin](https://franklinjl.org/)を使ってサイトを作成する。
## Franklinとは
Franklinはmarkdown形式で記事を作成し、htmlに変換して出力する静的サイトジェネレータ。
Juliaでコンパイルするので独自コマンドを追加したり、Julia式を評価したりできる。
## テンプレートサイト作成
```julia-repl
(v1.6) pkg> add Franklin
julia> using Franklin
julia> newsite("mySite")
```
## GitHubにホスティング
サーバーは自前で用意せずGitHub Pagesを使う。
こうすることで維持費が必要ない。

[Create a new repository](https://github.com/new)
![](/assets/Github hosting.png)

Repository nameをユーザー名(dokudo91).github.ioにすることでGitHub Pagesでサイトを公開する事ができる。
作ったリポジトリのURLをコピーしてgitにpushする。

![](/assets/dokudo91 clone.png)
```julia-repl
shell> git init && git remote add origin git@github.com:dokudo91/dokudo91.github.io.git
shell> git add -A && git commit -am "initial files"
shell> git push --set-upstream origin master
```
SettingsのPagesでSourceをgh-pagesブランチに変更する。
![](/assets/GitHub Pages Settings.png)

# サイトマップ
sitemap.xmlは自動で作成される。
sitemap.xmlは検索エンジンにサイト情報を伝えるために存在している。
changefreqやpriorityなど指定できるがGoogleには無視されるようなのでデフォルトのままでいい。

# LaTeX-likeなコマンド
`\newcommand{\name}[...]{...}`という形でコマンドを定義する事ができる。
例えば、
```
\newcommand{\b}{~~~<br>~~~}
```
と定義してconfig.mdに追加しておけば、`\b`を文末に置くだけでhtmlでは改行`<br>`が出力される。