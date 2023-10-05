# This file was generated, do not modify it. # hide
θrange=1e-11:1e-13:1e-10
b_fa_dists=[Poisson(8*10^11*θ) for θ in θrange]
b_posterior_pdfs=[pdf(b_posterior_dist,θ) for θ in θrange]
predictive_fa_pdf(y)=sum(pdf.(b_fa_dists,y) .* b_posterior_pdfs .* 1e-13)
bar(0:100,predictive_fa_pdf,yrotation=90,label="predictive_fa_pdf")
savefig(joinpath(@OUTPUT, "predictive_fa_pdf.svg"))
nothing
