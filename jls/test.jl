using Statistics
maleheights=randn(100000) .* 10 .+ 170
femaleheights=randn(100000) .* 5 .+ 160
heights=[maleheights; femaleheights]

var_u=var(heights)

var_u_given_v=[var(maleheights); var(femaleheights)]
E_var_u_given_v = mean(var_u_given_v)
E_u_given_v=[mean(maleheights); mean(femaleheights)]
var_E_u_given_v = var(E_u_given_v)
E_var_u_given_v+var_E_u_given_v
var_u - (E_var_u_given_v+var_E_u_given_v)

minheight=floor(Int,minimum(heights)/10)*10
maxheight=floor(Int,maximum(heights)/10)*10
heightrange=minheight:10:maxheight
conditional_variances=[var(heights[x .< heights .≤ x+10]) for x in heightrange]
E_var_Y_given_X = mean(filter(!isnan, conditional_variances))
E_Y_given_X = [mean(heights[heights .≤ 165]), mean(heights[heights .> 165])]
E_Y_given_X = [mean(heights[x .< heights .≤ x+10]) for x in heightrange]
var_E_Y_given_X = var(E_Y_given_X)

using Distributions
X=0.6
# Define parameters
μm = 170
σm = 10
μf = 160
σf = 5

# Define the normal distributions
dist_male = Normal(μm, σm)
dist_female = Normal(μf, σf)

# Define the mixture model
Y = MixtureModel([dist_male, dist_female], [X, 1-X])
plot(x->pdf(Y,x),xlims=(140, 200))

# Calculate the explained variance
E_Y_given_X = X * μm + (1 - X) * μf
Var_E_Y = [(μm - mean(Y))^2, (μf - mean(Y))^2]
Var_E_Y_given_X = X * Var_E_Y[1] + (1-X) * Var_E_Y[2]
explained_variance = X * (μm - (X * μm + (1 - X) * μf))^2 + (1 - X) * (μf - (X * μm + (1 - X) * μf))^2

# Calculate the unexplained variance
unexplained_variance = X * σm^2 + (1 - X) * σf^2
Var_Y=[σm^2, σf^2]
E_Var_Y_given_X = X * σm^2 + (1 - X) * σf^2

# Calculate the total variance
total_variance = explained_variance + unexplained_variance