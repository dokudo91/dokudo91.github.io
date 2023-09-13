# This file was generated, do not modify it. # hide
contour(-0.5:0.01:0.5, -0.5:0.01:0.5, (x, y) -> pv([x, y]), size=(500, 400), yrotation=90)
savefig(joinpath(@OUTPUT, "pv.svg"))
nothing
