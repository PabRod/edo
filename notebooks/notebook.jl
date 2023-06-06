### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 7d0278af-5898-40af-b785-d60f246e3953
begin
	using Pkg
	Pkg.activate("..")

	using edo
	using Plots
end

# ╔═╡ 25c85724-046b-11ee-1315-ef92bbdd68de
md"""
# Differential equations solver
"""

# ╔═╡ fb0bb21f-cdd1-4230-9eff-449705bab835
md"""
## Load the required modules
"""

# ╔═╡ 3f1c1c5f-cf3d-4661-ba32-d130bd7e95db
md"""
## Pose a problem

### From the problems' collection

Some classical differential equations are available in `src/dynamics.jl`.
In the example below, we'll import a classical damped oscillator.
"""

# ╔═╡ 5e86aab5-84f3-4f60-a012-5c278246fba0
let
	# Analytical choices
	∂y∂t = edo.dynamics.oscillator(2π, 0.02)
	y₀ = [0, 1]

	# Numerical choices
	tₛ = Vector(LinRange(0, 10, 1001))
	∫ = edo.integrators.pred_corr_euler

	# Solve
	yₛ = edo.utils.tabulate(∂y∂t, ∫, y₀, tₛ)

	# Plot
	Plots.plot(tₛ, yₛ)
end

# ╔═╡ af7e768b-29b1-4d47-aeb7-cdb86f8118d5
md"""
### From user's input

The equation for a damped pendulum reads:

```math
\frac{d^2\theta}{dt^2} = - \frac{g}{l} \sin\theta - \frac{\gamma}{l} \frac{d\theta}{dt}
```

this can be converted into a first-degree differential equation:

```math
\begin{cases}
   \frac{d\theta}{dt} \equiv \omega  \\
   \frac{d\omega}{dt} = -\frac{g}{l}\sin\theta - \frac{\gamma}{l} \omega
\end{cases}
```

that can be coded as:
"""

# ╔═╡ 232cdc42-6f40-4203-abdd-1b85355b16a9
let
	## Analytical part
	g = 9.81
	l = 1
	γ = .5
	∂y∂t = (y, t) -> [y[2],
					  -g/l * sin(y[1]) - γ/l * y[2]]
	y₀ = [0, 2]

	# Numerical choices
	tₛ = Vector(LinRange(0, 10, 1001))
	∫ = edo.integrators.pred_corr_euler

	# Solve
	yₛ = edo.utils.tabulate(∂y∂t, ∫, y₀, tₛ)

	# Plot
	Plots.plot(tₛ, yₛ)
	
end

# ╔═╡ Cell order:
# ╟─25c85724-046b-11ee-1315-ef92bbdd68de
# ╟─fb0bb21f-cdd1-4230-9eff-449705bab835
# ╠═7d0278af-5898-40af-b785-d60f246e3953
# ╟─3f1c1c5f-cf3d-4661-ba32-d130bd7e95db
# ╠═5e86aab5-84f3-4f60-a012-5c278246fba0
# ╟─af7e768b-29b1-4d47-aeb7-cdb86f8118d5
# ╠═232cdc42-6f40-4203-abdd-1b85355b16a9
