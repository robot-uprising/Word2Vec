# module Word2Vec

using DataStructures: PriorityQueue
using TextAnalysis

import Base: show, size

include("proc_doc.jl")
include("huffman.jl")
include("wordvectors.jl")
include("network.jl")


# end
# doc = "..\\data\\shakespeare.txt"
# network = W2VNetwork(crps, 10, 300)
