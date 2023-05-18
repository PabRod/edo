module integrators

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


end