# This file was generated, do not modify it. # hide
function fquantile(py,yvalues,q)
    index=findfirst(≥(q),cumsum([py(y) for y in yvalues]))
    getindex(yvalues,index)
end
fquantile.(predictive_fa_pdf, Ref(1:100), [.025, .975])
