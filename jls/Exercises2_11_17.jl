using Distributions, StatsPlots, QuadGK

Chisq(10)

s_nonnorm_posterior_pdf(σ,n,ν)=σ^float(-n+1)*exp(-n*ν/(2*σ^2))
function s_constant(n,ν)
    result,_=quadgk(x->s_nonnorm_posterior_pdf(x,n,ν),0,Inf)
    result
end
s_posterior_pdf(σ,n,ν)=s_nonnorm_posterior_pdf(σ,n,ν)/s_constant(n,ν)
s2_nonnorm_posterior_pdf(σ²,n,ν)=σ²^float(-n+1)*exp(-n*ν/(2*σ²))
function s2_constant(n,ν)
    result,_=quadgk(x->s2_nonnorm_posterior_pdf(x,n,ν),0,Inf)
    result
end
s2_posterior_pdf(σ²,n,ν)=s2_nonnorm_posterior_pdf(σ²,n,ν)/s2_constant(n,ν)

plot(0:0.01:5,x->s_posterior_pdf(x,10,1))
plot!(0:0.01:5,x->s2_posterior_pdf(sqrt(x),10,1))

function fquantile(py,yvalues,q)
    index=findfirst(≥(q),cumsum([py(y)*step(yvalues) for y in yvalues]))
    getindex(yvalues,index)
end
fquantile.(x->s_posterior_pdf(x,10,1), Ref(0.01:0.01:5), [.025,.975])
fquantile.(x->s2_posterior_pdf(x,10,1), Ref(0.01:0.01:5), [.025,.975])