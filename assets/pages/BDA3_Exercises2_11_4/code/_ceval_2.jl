# This file was generated, do not modify it. # hide
py(y)=0.25pdf(y_dist(1//12),y)+0.5pdf(y_dist(1//6),y)+0.25pdf(y_dist(1//4),y)
plot(0:400,py,yrotation=90,label="p(y)")
plot!(conditional_y(1//12),label="p(y|θ=1/12)")
plot!(conditional_y(1//6),label="p(y|θ=1/6)")
plot!(conditional_y(1//4),label="p(y|θ=1/4)")
savefig(joinpath(@OUTPUT, "py.svg"))
nothing
