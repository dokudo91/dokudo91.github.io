using Distributions, StatsPlots
using StatsBase

# Step 1: Generate 500 θj values from Gamma(20, 430000)
θj_values = rand(Gamma(20, 1//430000), 500)

yjs = rand.(Poisson.(10000 .* θj_values))

# Print the counts
println("Counts:")
for (yj, count) in countmap(yjs) |> sort
    println("$yj's: $count")
end
