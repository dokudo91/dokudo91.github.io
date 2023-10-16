using DataFrames, CSV
io=IOBuffer("""
Bush Dukakis other
294 307 38
288 332 19
""")
df = CSV.File(io, delim = ' ', header=true) |> DataFrame

using Distributions
posterior_dists=Dirichlet.([collect(df[i,:]) .+ 1 for i in 1:2])
function predict(dist)
    θs = rand(dist)
    rand(Multinomial(639, θs))
end

using StatsPlots
posterior1_predicts = [predict(posterior_dists[1]) for _ in 1:1000]
yBush1=getindex.(posterior1_predicts, 1)
yDukakis1=getindex.(posterior1_predicts, 2)
stephist(yBush1, label="pre-debate Bush")
stephist!(yDukakis1, label="pre-debate Dukakis")
mean(yBush1), std(yBush1)
mean(yDukakis1), std(yDukakis1)

posterior2_predicts = [predict(posterior_dists[2]) for _ in 1:1000]
yBush2=getindex.(posterior2_predicts, 1)
yDukakis2=getindex.(posterior2_predicts, 2)
stephist(yBush2, label="post-debate Bush")
stephist!(yDukakis2, label="post-debate Dukakis")
mean(yBush2), std(yBush2)
mean(yDukakis2), std(yDukakis2)

α1_dist=Beta(295,308)
plot(α1_dist, label="pre-debate Bush", yrotation=90)
α2_dist=Beta(289,333)
plot!(α2_dist, label="post-debate Bush")

dif = rand(α2_dist, 1000) .- rand(α1_dist, 1000)
histogram(dif, label="α2 - α1")