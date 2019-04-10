import Random: shuffle!

struct CBOWData
    model::Symbol
    cd::ContextData
end

function shuffle!(data::CBOWData)
    shuffle!(data.cd)
end

function Base.length(data::CBOWData)
    return length(data.cd)
end

function Base.iterate(data::CBOWData, state = 1)
    if state < 1 || state > length(data) + 1
        error("Invalid iterator state parameter")
    elseif state == length(data) + 1
        return nothing
    else
        (context, _) = iterate(data.cd, state)
        isodd(length(context)) ? wordloc = Int(ceil(length(context)/2)) :
                                wordloc = Int(floor(length(context)/2))
        word = context[wordloc]
        window = vcat(context[1:wordloc-1], context[wordloc+1:end])
        if data.model == :cbow
            return ((window, word), state + 1)
        elseif data.model == :skipgram
            return ((word, window), state + 1)
        else
            error("model of type $(data.model) not supported")
        end
    end
end
