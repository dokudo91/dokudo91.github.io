# This file was generated, do not modify it. # hide
histogram(outcomes - df.spread, normalize=:pdf, label="outcome - point spread", yrotation=90)
plot!(fitted, label="Normal PDF")
savefig(joinpath(@OUTPUT, "football_fitted.svg"))
nothing