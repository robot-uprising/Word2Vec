import Random: shuffle!

struct CBOWData
    ordering::Array{Tuple}
    xs::Array{Context}
end

CBOWData() = CBOWData([],[])

function Base.push!(data::CBOWData, c::Context)
    push!(data.xs, c)
    position = length(data.xs)
    num_contexts = length(c.xs) + 1 - c.n
    for i in 1:num_contexts
        push!(data.ordering, (position, i))
    end
end

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
        (contextid, context_state) = cd.ordering[state]
        (context, _) = iterate(cd.xs[contextid], context_state)
        isodd(length(context)) ? wordloc = Int(ceil(length(context)/2)) :
                                wordloc = Int(floor(length(context)/2))
        word = context[wordloc]
        window = vcat(context[1:wordloc-1], context[wordloc+1:end])
        return ((window, word), state + 1)
    end
end
