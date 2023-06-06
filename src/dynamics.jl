module dynamics

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

end