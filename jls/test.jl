using Distributions, StatsPlots, ForwardDiff, LinearAlgebra

# Define the original density function pu(u) (in this case, a uniform distribution)
pu=MvNormal([0,0],[1 0; 0 1])
f(u) = u.^3
f_inv(v) = abs.(v).^(1/3) .* sign.(v)
Jacobian(v)=ForwardDiff.jacobian(f_inv,v)
pv(v) = det(Jacobian(v)) * pdf(pu, f_inv(v))

contour(-0.5:0.01:0.5, -0.5:0.01:0.5, (x, y) -> pdf(pu, [x, y]), size=(400, 400))
contour(-0.5:0.01:0.5, -0.5:0.01:0.5, (x, y) -> pv([x, y]), size=(400, 400))

# Test with an example value of v
v_example = [1,0.5]
result = pv(v_example)

println("pv($v_example) = $result")

