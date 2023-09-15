# This file was generated, do not modify it. # hide
function Pr(n, θ)
    samples_nθ=samples(n, θ)
    count(abs.(samples_nθ ./ n .- θ) .> ε) / length(samples_nθ)
end
Pr(10, 0.5)
