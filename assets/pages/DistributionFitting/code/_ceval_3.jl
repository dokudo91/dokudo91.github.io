# This file was generated, do not modify it. # hide
histogram(outcomes - df.spread, label="outcome - point spread", yrotation=90)
savefig(joinpath(@OUTPUT, "football.svg"))
nothing
