using Distributions, StatsPlots

prior_dist = Beta(1,1)
posterior_dist = Beta(438, 544)

quantile(posterior_dist,[.025,.975])
th = rand(posterior_dist,10000)
phi = (1 .- th) ./ th
histogram(phi)

function noncon_prior_pdf(x)
    if x < 0.385
        x1,y1 = (0,1)
        x2,y2 = (0.385,1)
    elseif 0.385 ≤ x < 0.485
        x1,y1 = (0.385,1)
        x2,y2 = (0.485,11)
    elseif 0.485 ≤ x < 0.585
        x1,y1 = (0.485,11)
        x2,y2 = (0.585,1)
    elseif 0.585 ≤ x
        x1,y1 = (0.585,1)
        x2,y2 = (1,1)
    end
    a, b = [x1 1; x2 1]\[y1; y2]
    a*x + b
end

nonnormalized_posterior_noncon_pdf(x) = pdf(Binomial(980,x),437) * noncon_prior_pdf(x)
constant = sum(nonnormalized_posterior_noncon_pdf(x)*0.001 for x in 0:0.001:1)
normalized_posterior_noncon_pdf(x) = nonnormalized_posterior_noncon_pdf(x) / constant
plot(0.3:0.001:0.6, normalized_posterior_noncon_pdf)
plot!(0.3:0.001:0.6, noncon_prior_pdf)
plot!(0.3:0.001:0.6, posterior_dist)

pc = cumsum(normalized_posterior_noncon_pdf(x)*0.001 for x in 0:0.001:1)
sum(pc .< rand())
wsample(0:0.001:1,normalized_posterior_noncon_pdf.(0:0.001:1),10)