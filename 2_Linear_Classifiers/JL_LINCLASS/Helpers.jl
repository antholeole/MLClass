using Plots
using LaTeXStrings
using Distributions
using Random
using LinearAlgebra

import Base.filter,.map

# will be std in 1.9
function filter(f)
    v::Vector -> filter(f, v)
end

function map(f)
    v::Vector -> map(f, v)
end

## Code

function generatedata(
    n::Integer,
    std_x1::Number,
    std_x2::Number,
    mean_x1::Number,
    mean_x2::Number,
)::Matrix{Float64}
    x1 = rand(Normal(mean_x1, std_x1), n)
    x2 = rand(Normal(mean_x2, std_x2), n)
    return hcat(x2, x1)
end

function plotdata!(
    p::Plots.Plot,
    datapoints::Matrix{Float64},
    labels::Vector{Int8},
    hyperplane::Vector{Float64},
)
    w1, w2, bias = hyperplane

    a_pts = [datapoints[i, :] for i = 1:size(datapoints,  1) if labels[i] == -1]
    b_pts = [datapoints[i, :] for i = 1:size(datapoints,  1) if labels[i] == 1]

    #=
    weights (and bias) are in the form x1*w1 + x2*w2 + b = 0.
    to get the visual representation, it makes sense to convert it to
    the form y = mx + b; in this case, b stays as bias, y is x1, and m is x2.

    x1*w1 = x2 * w2 + -b
    x1 = x2 * (w2 / w1) - b / w1
    =#

    scatter!(p, getindex.(a_pts, 1), getindex.(a_pts, 2), label="a")
    scatter!(p, getindex.(b_pts, 1), getindex.(b_pts, 2), label="b")

    xlabel!(p, L"x_2")
    ylabel!(p, L"x_1")
    ylims!(p, 0, 10) # the legend covers the data otherwise

    f_hyperplane = x2 -> -(w1 * x2 + bias) / w2

    plot(p, f_hyperplane, label="hyperplane ($w1, $w2, $bias)")
end
