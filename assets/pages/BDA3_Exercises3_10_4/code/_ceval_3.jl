# This file was generated, do not modify it. # hide
posterior_p0_alt = rand(Beta(39+2,674-39+2),5000)
posterior_p1_alt = rand(Beta(22+2,680-22+2),5000)
odds_ratio_alt = (posterior_p1_alt ./ (1 .- posterior_p1_alt)) ./ (posterior_p0_alt ./ (1 .- posterior_p0_alt))
histogram(odds_ratio_alt, label="odds ratio", yrotation=90)
savefig(joinpath(@OUTPUT, "odds_ratio_alt.svg"))
quantile(odds_ratio_alt, [.025,.975])
