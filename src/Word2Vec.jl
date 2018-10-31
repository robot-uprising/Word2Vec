# module Word2Vec

using TextAnalysis
using DataStructures
using LinearAlgebra
using Flux

import Base: show, size

include("proc_doc.jl")
include("huffman.jl")
include("network.jl")
include("wordvectors.jl")
include("interface.jl")

# end
