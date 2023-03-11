struct DownsampledData{T<:TextData, F<:AbstractFloat} <: TextData
    downdata::T
    threshold::F
end

function downsample(data::TextData, threshold::AbstractFloat)
    DownsampledData(data, threshold)
end


function Base.iterate(data::DownsampledData)
    error("you didn't implement this yet, dummy")
end

struct MiniBatchData{T<:Iterators.PartitionIterator{<:TextData}}
    minidata::T
end

function minibatch(data::TextData, n::Integer)
    minidata = (Iterators.partition(data, n))
    MiniBatchData(minidata)
end

Base.length(data::MiniBatchData) = length(data.minidata)

function Base.iterate(data::MiniBatchData, state = 1)
    temp = iterate(data.minidata, state)
    if temp === nothing
        return nothing
    else
        (temp, newstate) = temp
        temp = Iterators.Stateful(temp)
        X, Y = iterate(temp)[1]
        for (i, j) in temp
            X = hcat(X, i)
            Y = vcat(Y, j)
        end
    end
    return ((X, Y), newstate)
end
