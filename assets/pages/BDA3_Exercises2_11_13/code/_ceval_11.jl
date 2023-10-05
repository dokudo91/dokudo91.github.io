# This file was generated, do not modify it. # hide
crange=600:0.1:800
c_dists=[Poisson(θ) for θ in crange]
c_posterior_pdfs=[pdf(c_posterior_dist,θ) for θ in crange]
c_predictive_pdf(y)=sum(pdf.(c_dists,y) .* c_posterior_pdfs .* 0.1)
bar(500:1200,c_predictive_pdf,yrotation=90,label="c_predictive_pdf")
savefig(joinpath(@OUTPUT, "c_predictive_pdf.svg"))
nothing
