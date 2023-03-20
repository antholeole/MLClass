using Plots

include("Helpers.jl")

function lsrl(
    data::Matrix{Float64},
    labels::Vector{Int8}
)
    x = hcat(data, ones(size(data, 1), 1)) # add bias
    x_transposed = transpose(x)

    inv(x_transposed * x) * x_transposed * labels
end

a_count = 20
b_count = 50

datapoints = vcat(generatedata(a_count, .1, 0.1, 2, 1), generatedata(b_count, .1, 0.1, 4, 2))
labels = vcat(fill(Int8(1), a_count), fill(Int8(-1), b_count))

w = lsrl(datapoints, labels)
p = plot()
plotdata!(p, datapoints, labels, w)
