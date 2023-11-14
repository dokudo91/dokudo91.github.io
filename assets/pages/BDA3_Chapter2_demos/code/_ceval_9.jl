# This file was generated, do not modify it. # hide
function noncon_prior_pdf(x)
    if x < 0.385
        x1,y1 = (0,1)
        x2,y2 = (0.385,1)
    elseif 0.385 ≤ x < 0.485
        x1,y1 = (0.385,1)
        x2,y2 = (0.485,11)
    elseif 0.485 ≤ x < 0.585
        x1,y1 = (0.485,11)
        x2,y2 = (0.585,1)
    elseif 0.585 ≤ x
        x1,y1 = (0.585,1)
        x2,y2 = (1,1)
    end
    a, b = [x1 1; x2 1]\[y1; y2]
    a*x + b
end
plot(0:0.001:1, noncon_prior_pdf,yrotation=90,label="nonconjugate")
savefig(joinpath(@OUTPUT, "noncon_prior_pdf.svg"))
nothing
