using Distributions, StatsPlots
y_dist(θ)=Normal(1000*θ,sqrt(1000*θ*(1-θ)))
plot(y_dist(1//12),label="θ=1/12",yrotation=90)
plot!(y_dist(1//6),label="θ=1/6")
plot!(y_dist(1//4),label="θ=1/4")

py(y)=0.25pdf(y_dist(1//12),y)+0.5pdf(y_dist(1//6),y)+0.25pdf(y_dist(1//4),y)
plot(0:400,py)
function fquantile(py,yvalues,q)
    index=findfirst(≥(q),cumsum([py(y) for y in yvalues]))
    getindex(yvalues,index)
end
fquantile.(py, Ref(1:1000), [.05, .25, .5, .75, .95])