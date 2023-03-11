module ContextDataTypes

abstract type TextData end

include("context_iterator.jl")
include("wrappers.jl")
include("word2vecdata.jl")

export TextData, Context, W2VData, word2vecdata,
        DownsampledData, downsample, MiniBatchData, minibatch

end
