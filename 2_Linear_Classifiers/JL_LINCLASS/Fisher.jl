using Plots

include("Helpers.jl")

function fisher(
    p::Plots.Plot,
    datapoints::Matrix{Float64},
    labels::Vector{Int8}
)
    a_pts = reduce(hcat, [datapoints[i, :] for i = 1:size(datapoints,  1) if labels[i] == -1])
    b_pts = reduce(hcat, [datapoints[i, :] for i = 1:size(datapoints,  1) if labels[i] == 1])

    pre_projection_centers = hcat([[1 / size(pts, 2) * sum(pts[feat, :]) for feat in axes(pts, 1)] for pts in [a_pts, b_pts]])

    # this should almost be entirely covered by the data
    scatter!(p, pre_projection_centers[2, :], pre_projection_centers[1, :], label="center")
end

a_count = 20
b_count = 50

datapoints = vcat(generatedata(a_count, .1, 0.1, 2, 1), generatedata(b_count, .1, 0.1, 4, 2))
labels = vcat(fill(Int8(1), a_count), fill(Int8(-1), b_count))

p = plot()
fisher(p, datapoints, labels)
plotdata!(p, datapoints, labels, w)


