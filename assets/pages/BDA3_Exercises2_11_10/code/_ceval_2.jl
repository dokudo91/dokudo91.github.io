# This file was generated, do not modify it. # hide
likelihood(y,N)=ifelse(N<y,0,1/N)
plot(1:1000,N->likelihood(203,N),label="likelihood",yrotation=90)
savefig(joinpath(@OUTPUT, "likelihood.svg"))
nothing
