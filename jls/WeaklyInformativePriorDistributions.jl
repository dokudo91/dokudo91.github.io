using StatsBase, StatsPlots, GLM, Random

n = 100  # Number of patients
treatment = rand([0, 1], n)
log_odds = 0.5 * treatment + randn(n)  # Simulated log-odds
logistic(x) = 1 / (1 + exp(-x))
prob_survival = logistic.(log_odds)

using DataFrames
data = DataFrame(treatment=treatment, prob_survival=prob_survival)

logit_model = glm(@formula(treatment ~ 1), data, Binomial(), LogitLink())
plot(logit_model, group=:treatment)