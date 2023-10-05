using Distributions, StatsPlots

fatal_accidents=[24,25,31,31,22,21,26,20,16,22]
fa_dist(θ)=Poisson(θ)
fa_rate_posterior_dist=Gamma(-1//2+length(fatal_accidents)*mean(fatal_accidents),1//length(fatal_accidents))
θsamples=rand(fa_rate_posterior_dist,1000)
fa_dists=[Poisson(θ) for θ in 0:0.1:100]
fa_rate_posterior_pdfs=[pdf(fa_rate_posterior_dist,θ) for θ in 0:0.1:100]
predictive_fa_pdf(y)=sum(pdf.(fa_dists,y) .* fa_rate_posterior_pdfs .* 0.1)
bar(1:100,predictive_fa_pdf)
function fquantile(py,yvalues,q)
    index=findfirst(≥(q),cumsum([py(y) for y in yvalues]))
    getindex(yvalues,index)
end
fquantile.(predictive_fa_pdf, Ref(1:100), [.025, .975])

using DataFrames, CSV
io=IOBuffer("""
Year FatalAccidents PassengerDeaths DeathRate
1976 24 734 0.19
1977 25 516 0.12
1978 31 754 0.15
1979 31 877 0.16
1980 22 814 0.14
1981 21 362 0.06
1982 26 764 0.13
1983 20 809 0.13
1984 16 223 0.03
1985 22 1066 0.15
""")
df = CSV.File(io, delim = ' ', header=true) |> DataFrame
passenger_miles = df.PassengerDeaths ./ df.DeathRate .*10^8
b_posterior_dist=Gamma(1//2+sum(df.FatalAccidents),1/sum(passenger_miles))
θrange=1e-11:1e-13:1e-10
b_fa_dists=[Poisson(8*10^11*θ) for θ in θrange]
b_posterior_pdfs=[pdf(b_posterior_dist,θ) for θ in θrange]
predictive_fa_pdf(y)=sum(pdf.(b_fa_dists,y) .* b_posterior_pdfs .* 1e-13)
fquantile.(predictive_fa_pdf, Ref(1:100), [.025, .975])

n=length(df.PassengerDeaths)
c_posterior_dist=Gamma(1//2+sum(df.PassengerDeaths),1//n)
crange=600:0.1:800
c_dists=[Poisson(θ) for θ in crange]
c_posterior_pdfs=[pdf(c_posterior_dist,θ) for θ in crange]
c_predictive_pdf(y)=sum(pdf.(c_dists,y) .* c_posterior_pdfs .* 0.1)
bar(500:1000,c_predictive_pdf,yrotation=90,label="c_predictive_pdf")

d_posterior_dist=Gamma(1//2+sum(df.PassengerDeaths),1/sum(passenger_miles))
dθrange=1e-9:1e-12:2e-9
d_pd_dists=[Poisson(8*10^11*θ) for θ in dθrange]
d_posterior_pdfs=[pdf(d_posterior_dist,θ) for θ in dθrange]
d_predictive_pd_pdf(y)=sum(pdf.(d_pd_dists,y) .* d_posterior_pdfs .* 1e-12)
fquantile.(d_predictive_pd_pdf, Ref(100:2000), [.025, .975])
