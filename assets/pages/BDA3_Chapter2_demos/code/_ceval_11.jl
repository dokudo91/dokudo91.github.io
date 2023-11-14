# This file was generated, do not modify it. # hide
s = wsample(0:0.001:1,normalized_posterior_noncon_pdf.(0:0.001:1),10000)
histogram(s,yrotation=90,label="posterior")
savefig(joinpath(@OUTPUT, "histogram.svg"))
nothing
