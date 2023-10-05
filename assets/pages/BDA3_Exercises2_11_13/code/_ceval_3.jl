# This file was generated, do not modify it. # hide
fa_dists=[Poisson(θ) for θ in 0:0.1:100]
fa_rate_posterior_pdfs=[pdf(fa_rate_posterior_dist,θ) for θ in 0:0.1:100]
predictive_fa_pdf(y)=sum(pdf.(fa_dists,y) .* fa_rate_posterior_pdfs .* 0.1)
bar(1:100,predictive_fa_pdf,yrotation=90,label="posterior predictive y")
savefig(joinpath(@OUTPUT, "predictive_fa_pdf.svg"))
nothing
