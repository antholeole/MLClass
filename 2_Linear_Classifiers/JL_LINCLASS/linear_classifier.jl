## Prelude

using Plots
using LaTeXStrings
using Distributions
using Random

import Base.filter,.map

# will be std in 1.9
function filter(f)
    v::Vector -> filter(f, v)
end

function map(f)
    v::Vector -> map(f, v)
end

## Code

@enum BinaryClassification begin
    a = -1
    b = 1
end


function generatedata(
    n::Integer,
    std_x1::Number,
    std_x2::Number,
    mean_x1::Number,
    mean_x2::Number,
    label::BinaryClassification,
)::Vector{<:Tuple{Number, Number, BinaryClassification}}
    x1 = rand(Normal(mean_x1, std_x1), n)
    x2 = rand(Normal(mean_x2, std_x2), n)
    return map((x1, x2) -> (x1, x2, label), x1, x2)
end

function plotdata(
    data::Vector{<:Tuple{Number, Number, BinaryClassification}},
    hyperplane::Tuple{Number, Number, Number},
)
    w1, w2, bias = hyperplane

    a_pts = data |> filter(d -> d[3] == a::BinaryClassification) |> map(d -> d[1:2])
    b_pts = data |> filter(d -> d[3] == b::BinaryClassification) |> map(d -> d[1:2])

    #=
    weights (and bias) are in the form x1*w1 + x2*w2 + b = 0.
    to get the visual representation, it makes sense to convert it to
    the form y = mx + b; in this case, b stays as bias, y is x1, and m is x2.

    x1*w1 = x2 * w2 + -b
    x1 = x2 * (w2 / w1) - b / w1
    =#

    p = scatter(getindex.(a_pts, 1), getindex.(a_pts, 2), label="a")
    scatter!(p, getindex.(b_pts, 1), getindex.(b_pts, 2), label="b")
    xlabel!(p, L"x_2")
    ylabel!(p, L"x_1")

    f_hyperplane = x2 -> -(w2 * x2 + bias) / w1
    plot!(p, f_hyperplane, label="hyperplane")
end


plotdata(
    [
        generatedata(20, .1, 0.1, 2, 1, a::BinaryClassification);
        generatedata(50, .1, 0.1, 4, 2, b::BinaryClassification)
    ],
    (1, 2, -10)
)
