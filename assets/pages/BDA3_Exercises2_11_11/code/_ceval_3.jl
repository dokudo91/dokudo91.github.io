# This file was generated, do not modify it. # hide
likelihood_pdf(θ)=prod(pdf.(Cauchy(θ),[43,44,45,46.5,47.5]))
plot(0:0.1:100,x->likelihood_pdf(x),label="likelihood",yticks=nothing)
savefig(joinpath(@OUTPUT, "likelihood.svg"))
nothing
