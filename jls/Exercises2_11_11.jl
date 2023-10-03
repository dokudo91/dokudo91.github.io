using Distributions, StatsPlots, QuadGK
prior_pdf(θ)=pdf(Uniform(0,100),θ)
likelihood_pdf(θ)=prod(pdf.(Cauchy(θ),[43,44,45,46.5,47.5]))
unnormalized_posterior_pdf(θ)=prior_pdf(θ)*likelihood_pdf(θ)
marginal_pdf,_=quadgk(unnormalized_posterior_pdf,0,100)
posterior_pdf(θ)=unnormalized_posterior_pdf(θ)/marginal_pdf
posteriorθ_samples=wsample(0:0.01:100, posterior_pdf.(0:0.01:100), 1000)
posterior_y_dist=fit(Cauchy,posteriorθ_samples)
histogram(rand(posterior_y_dist,1000))

posterior_y(y)=sum(pdf(Cauchy(θ),y)*posterior_pdf(θ)*0.01 for θ in 0:0.01:100)

function generate_samples(posterior,range,n)
    samples=Float64[]
    for _ in 1:n
        while true
            θ = rand(range)
            acceptance_prob=posterior(θ)
            if rand() < acceptance_prob
                push!(samples,θ)
                break
            end
        end
    end
    return samples
end
samples=generate_samples(posterior_pdf,Uniform(1,100),1000)

plot(0:0.01:100,posterior_pdf)

using Turing
@model function cauchymodel(y)
    θ ~ Uniform(0,100)
    @. y ~ Cauchy(θ)
end
model=cauchymodel([43,44,45,46.5,47.5])
chain=sample(model,NUTS(),1000)