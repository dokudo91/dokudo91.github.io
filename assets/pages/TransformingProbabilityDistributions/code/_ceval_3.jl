# This file was generated, do not modify it. # hide
using ForwardDiff
Jacobian(v)=ForwardDiff.jacobian(f_inv,v)
Jacobian([-0.5, 0.3])
