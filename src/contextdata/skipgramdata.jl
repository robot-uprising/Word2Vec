using SparseArrays

import Random: shuffle!

struct SkipGramData{A<:AbstractArray{<:Tuple{<:Integer, <:Integer, <:Integer}, 1}, B<:AbstractArray{<:Context{<:Integer, <:AbstractArray{<:Integer,1}}, 1}, C<:Integer, D<:AbstractDict{<:Integer, <:AbstractFloat}} <: TextData
    ordering::A # to implement with iteration interface
    xs::B # the contexts and words to iterate over
    n::C # the size of the vocabulary
    freq_table::D
end

function Base.push!(data::SkipGramData, c::Context)
    push!(data.xs, c)
    position = length(data.xs)
    num_contexts = length(c.xs)
    for i in 1:num_contexts
        words = length(iterate(c, i)[1][2])
        for j in 1:words
            push!(data.ordering, (position, i, j))
        end
    end
end

SkipGramData(n::Int, freq_table::Dict) = SkipGramData(Tuple{Int, Int, Int}[],Context{Int, Array{Int,1}}[],n, freq_table)

function shuffle!(data::SkipGramData)
    shuffle!(data.ordering)
    return nothing
end

function Base.length(data::SkipGramData)
    return length(data.ordering)
end

function Base.iterate(data::SkipGramData, state = 1)
    if state < 1 || state > length(data) + 1
        error("Invalid iterator state parameter")
    elseif state == length(data) + 1
        return nothing
    else
        (contextid, context_state, word_id) = data.ordering[state]
        (context, _) = iterate(data.xs[contextid], context_state)
        x = SparseVector(data.n, Int[context[1]], [1])
        y = iterate(context[2], word_id)[1]
        return ((x, y), state + 1)
    end
end
