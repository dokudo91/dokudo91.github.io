using Distributions, Plots


ε = 0.1  # Fixed value of ε

# Generate samples from a Binomial distribution
samples(n, θ) = rand(Binomial(n, θ), 100)
function Pr(n, θ)
    samples_nθ=samples(n, θ)
    count(abs.(samples_nθ ./ n .- θ) .> ε) / length(samples_nθ)
end
Pr(n)=Pr(n, 0.4)
plot(1:10:500, Pr)