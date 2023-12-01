# This file was generated, do not modify it. # hide
sample_means = mean.(samples)
histogram(sample_means, yrotation=90, label="sample_means", bins=20)
savefig(joinpath(@OUTPUT, "histogram.svg"))
nothing
