import Random: shuffle!

struct W2VData{A<:AbstractArray{<:Tuple{<:Integer, <:Integer}, 1}, B<:AbstractArray{<:Context{<:Integer, <:AbstractArray{<:Integer,1}}, 1}, D<:AbstractDict{<:Integer, <:AbstractFloat}} <: TextData
    ordering::A # to implement with iteration interface
    xs::B # the contexts and words to iterate over
    freq_table::D # used for downsampling
end

function Base.push!(data::W2VData, c::Context)
    push!(data.xs, c)
    position = length(data.xs)
    for i in 1:length(c)
        push!(data.ordering, (position, i))
    end
end

word2vecdata(freq_table::Dict) = W2VData(Tuple{Int, Int}[], Context{Int, Array{Int,1}}[], freq_table)

function shuffle!(data::W2VData)
    shuffle!(data.ordering)
    return nothing
end

function Base.length(data::W2VData)
    return length(data.ordering)
end

function Base.iterate(data::W2VData, state = 1)
    if state < 1 || state > length(data) + 1
        error("Invalid iterator state parameter")
    elseif state == length(data) + 1
        return nothing
    else
        (contextid, context_state) = data.ordering[state]
        (context, _) = iterate(data.xs[contextid], context_state)
        y = context[1]
        x = context[2]
        return ((x,y), state + 1)
    end
end

function Base.show(io::IO, data::W2VData)
    num_sentences = length(data.xs)
    num_contexts = length(data)
    println("Iterable Word2Vec data with $num_sentences sentences and $num_contexts word-context pairs")
end

