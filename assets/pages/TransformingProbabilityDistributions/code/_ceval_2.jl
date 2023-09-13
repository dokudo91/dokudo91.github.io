# This file was generated, do not modify it. # hide
f(u) = u.^3
f_inv(v) = abs.(v).^(1/3) .* sign.(v)
f_inv([-0.5, 0.3])
