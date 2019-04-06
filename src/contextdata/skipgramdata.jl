import Random: shuffle!

struct SkipGramData
    ordering::Array{Tuple}
    xs::Array{Context}
end

SkipGramData() = SkipGramData([],[])

function Base.push!(data::SkipGramData, c::Context)
    push!(data.xs, c)
    position = length(data.xs)
    num_contexts = length(c.xs) + 1 - c.n
    for i in 1:num_contexts
        for j in 1:c.n-1
            push!(data.ordering, (position, i, j))
        end
    end
end

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
        isodd(length(context)) ? wordloc = Int(ceil(length(context)/2)) :
                                wordloc = Int(floor(length(context)/2))
        word = context[wordloc]
        window = vcat(context[1:wordloc-1], context[wordloc+1:end])
        return ((word, window[word_id]), state + 1)
    end
end
