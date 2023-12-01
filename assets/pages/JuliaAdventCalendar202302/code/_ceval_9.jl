# This file was generated, do not modify it. # hide
samples = [rand(uniform,10) for _ in 1:5000]
sample_means = mean.(samples)
histogram(sample_means, yrotation=90, label="sample_means", bins=20)
savefig(joinpath(@OUTPUT, "histogram2.svg"))
nothing
