module edo

greet() = print("Hello World!")

"""
    euler(∂y∂t, y₀, [t₀=.0, t₁=.01])

Updates the state using the forward Euler method
"""
function euler(∂y∂t, y₀, t₀=0.0, t₁=0.01)
    Δt = t₁ - t₀
    Δy = ∂y∂t(y₀, t₀) * Δt
    y₁ = y₀ + Δy
    return (y₁)
end

"""
    pred_corr_euler(∂y∂t, y₀, [t₀=.0, t₁=.01])

Updates the state using the prediction-correction 
Euler method
"""
function pred_corr_euler(∂y∂t, y₀, t₀=0.0, t₁=0.01)
    Δt = t₁ - t₀
    yₐ = euler(∂y∂t, y₀, t₀, t₁)
    Δy = (∂y∂t(y₀, t₀) + ∂y∂t(yₐ, t₀)) * Δt / 2
    y₁ = y₀ + Δy
    return (y₁)
end

"""
    tabulate(∂y∂t, ∫, y₀, ts)

Given a dynamic, an integrator, an initial state and a set of times,
returns the states corresponding to those times.
"""
function tabulate(∂y∂t, ∫, y₀, ts)

    ## Initialize container for results
    ys = Array{Float64}(undef, length(ts), length(y₀))
    ys[1, :] .= y₀

    ## Iterate
    for i in 2:lastindex(ts)
        ys[i, :] .= ∫(∂y∂t, ys[i-1, :], ts[i-1], ts[i])
    end

    return (ys)

end

"""
    decay([r])

Returns a linear decay differential equation
"""
function decay(r=1)
    return ((y, t=0) -> -r * y)
end

"""
    logistic([r, k])

Returns a logistic growth differential equation
"""
function logistic(r=1, k=1)
    return ((y, t=0) -> r * y * (1 - y / k))
end

"""
    oscillator([ω, ζ])

Returns a damped oscillator differential equation
"""
function oscillator(ω₀=2π, ζ=0.0)
    function ∂y∂t(y, t=0.0)
        return ([y[2],
            -2 * ζ * ω₀ * y[2] - ω₀^2 * y[1]])
    end
end

end # module edo