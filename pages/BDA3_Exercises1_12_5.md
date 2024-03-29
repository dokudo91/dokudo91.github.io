@def title = "BDA3の1.12 Exercisesの5を解く"
@def tags = ["julia", "BDA3"]
@def description = "BDA3の1.12 Exercisesの5を解く。"
{{fill description}}
本文は[Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/)。
解答参考は[Solutions to some exercises from Bayesian Data Analysis](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf)。

# 5. Probability assignment
ある選挙に対し、2人の候補がいる。投票数が同数になる可能性はどの程度あるか？

## (a) 雑な推定
yをA候補が獲得する投票数、nを総投票数とする。
2人の候補に関する事前情報は何もないので、Aが獲得する票は0.1から0.9の割合の中に入るとする。
もし、nが奇数であれば同数になることはない。
$$
Pr(y=\frac{n}{2}|n)=0
$$
nが偶数であれば、
$$
Pr(y=\frac{n}{2}|n)=\frac{1}{(0.9-0.1)}\frac{1}{n}
$$
である。
nが偶数になる確率は1/2とすると、$Pr(y=\frac{n}{2}|n)=\frac{1}{1.6n}=\frac{5}{8n}$である。
総投票数を20万(n=200000)とすると
```!
5//8//200000
```

### アメリカ議員選挙
アメリカの選挙区は435である。全ての区の総投票数を20万とする。全ての区で同数にならない確率は
$$
(1-\frac{1}{320000})^{435}
$$
である。少なくとも1つの区で同数になる確率は
$$
1-(1-\frac{1}{320000})^{435}
$$
```!
1-(1-1/320000)^435
```
0.136%である。

## (b) 追加情報を加味した推定
1900年から1992年の間に20,597の選挙が行われ、49の選挙が100票差だった。
この観測値を利用して同票になる確率を推定する。
A候補がy票であればB候補にはn-y票入っている。
その差y-(n-y)が100以下である確率は49/20597である。
$$
Pr(-100≤2y-n≤100)=\frac{49}{20597}
$$
-100から100の間のどの値となるかは等確率であるとする。
よって、2y-n=0→y=n/2(同票)になる確率は1/201である。
２つの確率を考慮して、
$$
Pr(y=n/2)=\frac{1}{201}\frac{49}{20597}
$$
```!
1//201*49//20597
```
である。
少なくとも1つの区で同数になる確率は
```!
1-(1-1/201*49/20597)^435
```
0.514%である。