module ContextDataTypes

abstract type TextData end

include("context_iterator.jl")
include("cbowdata.jl")
include("skipgramdata.jl")
include("wrappers.jl")

function word2vecdata(vector_size::Integer, freq_table::Dict, model::Symbol)
    if model == :cbow
        return CBOWData(vector_size, freq_table)
    elseif model == :skipgram
        return SkipGramData(vector_size, freq_table)
    else
        error("model of type $model not supported")
    end
end

export Context, TextData, CBOWData, SkipGramData, word2vecdata,
        DownsampledData, downsample, MiniBatchData, minibatch

end
