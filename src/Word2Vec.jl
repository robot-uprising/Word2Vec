# module Word2Vec

using TextAnalysis
using DataStructures: PriorityQueue
using LinearAlgebra: ⋅
using Flux: σ

import Base: show, size

include("proc_doc.jl")
include("huffman.jl")
include("wordvectors.jl")
include("network.jl")


# end
