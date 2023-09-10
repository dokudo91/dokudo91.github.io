# This file was generated, do not modify it. # hide
histogram(outcomes - df.spread, label="outcome - point spread")
savefig(joinpath(@OUTPUT, "football.png"))
nothing
