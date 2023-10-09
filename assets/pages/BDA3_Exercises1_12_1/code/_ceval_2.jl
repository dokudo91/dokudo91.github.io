# This file was generated, do not modify it. # hide
Pr(y)=0.5pdf(y1_dist(2),y)+0.5pdf(y2_dist(2),y)
plot!(Pr,label="Pr(y)")
savefig(joinpath(@OUTPUT, "Pry.svg"))
nothing
