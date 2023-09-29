# This file was generated, do not modify it. # hide
function fquantile(py,yvalues,q)
    index=findfirst(≥(q),cumsum([py(y) for y in yvalues]))
    getindex(yvalues,index)
end
yq=fquantile.(py, Ref(1:1000), [.05, .25, .5, .75, .95])
csv="""分位数,$(join([.05, .25, .5, .75, .95],","))
正規分布近似,$(join(yq,","))"""
write(joinpath(@OUTPUT,"quantile.csv"), csv)
nothing
