using Distributions, StatsPlots
prior_distribution=Uniform(0,1)
sampling_distribution(θ)=Binomial(10,θ)
joint_probability(θ,y)=pdf(prior_distribution,θ)*pdf(sampling_distribution(θ),y)
joint_probabilities=[joint_probability(θ,1) for θ in 0:0.01:1]
findmax(joint_probabilities)
plot(0:0.01:1, joint_probabilities)
marginal_likelihood(y)=sum(joint_probability(θ,y)*0.01 for θ in 0:0.01:1)
posterior_probability(θ,y)=joint_probability(θ,y)/marginal_likelihood(y)
posterior_density_=[posterior_probability(θ,3) for θ in 0:0.01:1]
plot(0:0.01:1, posterior_density_)