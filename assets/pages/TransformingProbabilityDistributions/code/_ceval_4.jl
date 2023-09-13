# This file was generated, do not modify it. # hide
using LinearAlgebra
pv(v) = det(Jacobian(v)) * pdf(pu, f_inv(v))
pv([-0.5, 0.3])
