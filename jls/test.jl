using Symbolics, Latexify, LaTeXStrings, Distributions

@variables σ y

# Define conditional probabilities
p_y_given_θ1 = 1/(sqrt(2Num(π))*σ) * exp(-(y - 1)^2 / (2*σ^2))
p_y_given_θ2 = 1/(sqrt(2Num(π))*σ) * exp(-(y - 2)^2 / (2*σ^2))

# Define prior probabilities
p_θ1 = 1//2
p_θ2 = 1//2

# Calculate marginal probability P(y)
p_y = p_θ1 * p_y_given_θ1 + p_θ2 * p_y_given_θ2
D = Differential(y)
replace(latexify(p_y),raw"\mathrm{identity}\left( \pi \right)"=>raw"\pi")|>LaTeXString
replace(latexify(D(p_y)|>expand_derivatives),raw"\mathrm{identity}\left( \pi \right)"=>raw"\pi")|>LaTeXString

using Distributions, StatsPlots