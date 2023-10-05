# This file was generated, do not modify it. # hide
dθrange=1e-9:1e-12:2e-9
d_pd_dists=[Poisson(8*10^11*θ) for θ in dθrange]
d_posterior_pdfs=[pdf(d_posterior_dist,θ) for θ in dθrange]
d_predictive_pd_pdf(y)=sum(pdf.(d_pd_dists,y) .* d_posterior_pdfs .* 1e-12)
bar(500:1200,d_predictive_pd_pdf,yrotation=90,label="d_predictive_pd_pdf")
savefig(joinpath(@OUTPUT, "d_predictive_pd_pdf.svg"))
nothing
