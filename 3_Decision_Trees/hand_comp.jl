struct Sample
    feat_a::Int
    feat_b::Int
    feat_c::Int
    class::Int
end

function gini_impurity(samples::Vector{Sample}, which)
    classes = unique(map(sample -> sample.class, samples))

    pr_classes = map(
        class -> count(sample -> sample.class == class && which(sample), samples) / max(count(which, samples), eps(0.0)),
        classes
    )

    sum(map(pr_class -> pr_class * (1 - pr_class), pr_classes))
end

function bad_dt(samples::Sample)
    if samples.feat_b > 8 && samples.feat_a > 5
        return 1
    end

    if samples.feat_a <= 5 && samples.feat_c > 3
        return 1
    end

    return -1
end



samples = [
    Sample(12, 3, 5, 1),
    Sample(4, 7, 6, 1),
    Sample(5, 4, 8, 1),
    Sample(6, 6, 7, 1),
    Sample(7, 5, 1, -1),
    Sample(8, 2, 2, -1),
    Sample(9, 6, 3, -1),
    Sample(11, 8, 1, -1)
]

println(gini_impurity(samples, sample -> sample.feat_a >= 5))
println(map(bad_dt, samples))

