module ContextDataTypes

include("context_iterator.jl")
include("cbowdata.jl")
include("skipgramdata.jl")

function word2vecdata(model::Symbol)
    if model == :cbow
        return CBOWData()
    elseif model == :skipgram
        return SkipGramData()
    else
        error("model of type $model not supported")
    end
end

export Context, CBOWData, SkipGramData, word2vecdata

end
