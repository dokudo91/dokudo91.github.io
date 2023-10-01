# This file was generated, do not modify it. # hide
τₙ²(n)=1//(1//40^2+n//20^2)
plot(1:50,n->sqrt(τₙ²(n)),yrotation=90,label="τₙ(n)")
savefig(joinpath(@OUTPUT, "variance.svg"))
nothing
