using Distributions

# Generate some random data
n = 20  # Data degrees of freedom
v = 3   # Prior degrees of freedom

# Simulated data (for illustration purposes)
y = rand(Normal(0, sqrt(10)), n)

# Calculate sample variance and degrees of freedom
sample_var = var(y)
sample_df = n - 1

# Define the parameters for the Inverse Gamma distribution
alpha = v/2  # Shape parameter
beta = v*sample_var/2  # Scale parameter

# Create an instance of the Inverse Gamma distribution
inv_chi2_dist = InverseGamma(alpha, beta)

# Generate some samples from the Inverse Gamma distribution
num_samples = 10000
samples = rand(inv_chi2_dist, num_samples)

# Compute the posterior estimate of the variance
posterior_variance = mean(samples)

# Compare with the sample variance
println("Sample Variance: ", sample_var)
println("Posterior Estimate of Variance: ", posterior_variance)
