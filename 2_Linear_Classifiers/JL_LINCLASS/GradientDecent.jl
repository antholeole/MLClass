include("Helpers.jl")

function gradientdescent(x::Matrix{Float64}, y::Vector{Int8}, w::Vector{Float64})
    x_aug = hcat(x, ones(size(x, 1), 1))

    A = x_aug * w .- y
    transpose(transpose(A) * x_aug)
end

a_count = 20
b_count = 50

datapoints = vcat(generatedata(a_count, .1, 0.1, 2, 1), generatedata(b_count, .1, 0.1, 4, 2))
labels = vcat(fill(Int8(1), a_count), fill(Int8(-1), b_count))



p = plot()
global w = [0.5, 0.5, 0.5]
@gif for i ∈ 1:300
    global w -= 0.001 * gradientdescent(datapoints, labels, w)
    plotdata!(p, datapoints, labels, w)
end every 5

