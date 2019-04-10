struct DownsampledData{T<:TextData, F<:AbstractFloat} <: TextData
    downdata::T
    threshold::F
end

function Base.iterate(data::DownsampledData)
    error("you didn't implement this yet, dummy")
end

struct MiniBatchData{T<:Iterators.PartitionIterator{<:TextData}}
    minidata::T
end

function MiniBatchData(data::TextData, n::Integer)
    minidata = (Iterators.partition(data, n))
    return MiniBatchData(minidata)
end

Base.length(data::MiniBatchData) = length(data.minidata)

function Base.iterate(data::MiniBatchData, state = 1)
    if state < 1 || state > length(data) + 1
        error("Invalid iterator state parameter")
    elseif state == length(data) + 1
        return nothing
    else
        (temp, newstate) = iterate(data.minidata, state)
        temp = Iterators.Stateful(temp)
        X, Y = iterate(temp)[1]
        for (i, j) in temp
            X = hcat(X, i)
            Y = hcat(Y, j)
        end
    end
    return ((X, Y), newstate)
end
