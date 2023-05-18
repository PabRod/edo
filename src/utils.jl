module utils

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

end