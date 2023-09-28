# This file was generated, do not modify it. # hide
csv="""分位数,$(join(q,","))
正規分布近似,$(join(round.(nayq;digits=2),","))
二項分布,$(join(yq,","))"""
write(joinpath(@OUTPUT,"quantile.csv"), csv)
nothing
