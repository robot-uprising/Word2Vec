using SparseArrays

import Random: shuffle!

struct CBOWData{A<:AbstractArray{<:Tuple{<:Integer, <:Integer}, 1}, B<:AbstractArray{<:Context{<:Integer, <:AbstractArray{<:Integer,1}}, 1}, C<:Integer,  D<:AbstractDict{<:Integer, <:AbstractFloat}} <: TextData
    ordering::A # to implement with iteration interface
    xs::B # the contexts and words to iterate over
    n::C # the size of the vocabulary
    freq_table::D
end

function Base.push!(data::CBOWData, c::Context)
    push!(data.xs, c)
    position = length(data.xs)
    num_contexts = length(c.xs)
    for i in 1:num_contexts
        push!(data.ordering, (position, i))
    end
end

CBOWData(n::Int, freq_table::Dict) = CBOWData(Tuple{Int, Int}[],Context{Int, Array{Int,1}}[],n, freq_table)

function shuffle!(data::CBOWData)
    shuffle!(data.ordering)
    return nothing
end

function Base.length(data::CBOWData)
    return length(data.ordering)
end

function Base.iterate(data::CBOWData, state = 1)
    if state < 1 || state > length(data) + 1
        error("Invalid iterator state parameter")
    elseif state == length(data) + 1
        return nothing
    else
        (contextid, context_state) = data.ordering[state]
        (context, _) = iterate(data.xs[contextid], context_state)
        y = SparseVector(data.n, Int[context[1]], [1])
        x = SparseVector(data.n, context[2], ones(length(context[2]))/length(context[2]))
        return ((x,y), state + 1)
    end
end
