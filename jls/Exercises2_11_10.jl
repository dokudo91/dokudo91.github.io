using Plots
Geometric(1/100)
prior(N)=1/100*(99/100)^(N-1)
likelihood(y,N)=ifelse(N<y,0,1/N)
predictive(y,summax,prior)=sum(prior(N)*likelihood(y,N) for N in 1:summax)
plot(1:1000,prior)
plot(1:1000,N->likelihood(203,N))
plot(1:1000,x->predictive(203,x,prior))
posterior(N,y,prior)=prior(N)*likelihood(y,N)/predictive(y,10000,prior)
plot(1:1000,N->posterior(N,203,prior))
plot(1:1000,N->posterior(N,203,x->1/1000))
plot(1:1000,N->posterior(N,203,x->pdf(DiscreteUniform(1000),x)))

using Distributions
DiscreteUniform(1000)