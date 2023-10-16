# This file was generated, do not modify it. # hide
function predict(dist)
    θs = rand(dist)
    rand(Multinomial(639, θs))
end
θs = rand(posterior_dists[1])
@show θs
rand(Multinomial(639, θs))
