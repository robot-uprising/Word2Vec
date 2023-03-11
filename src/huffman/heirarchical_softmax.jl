using DataStructures: PriorityQueue

struct HeirarchicalSoftmax{A<:AbstractArray{<:AbstractArray{<:Integer, 1}}}
    nodepaths::A
    branchpaths::A
end

"""
    init_softmax(pq::PriorityQueue, vocab_hash::Dict, vocab::Array)

TBW
"""
function init_softmax(pq::PriorityQueue, vocab_hash::Dict, vocab::Array)
    return HeirarchicalSoftmax(allpaths(HuffmanTree(pq, vocab_hash), vocab_hash, vocab)...)
end


import Base: show, size

function Base.show(io::IO, hs::HeirarchicalSoftmax)
    max_depth = maximum(length.(hs.branchpaths))
    print(io, "HeirarchicalSoftmax with a Huffman tree of depth $max_depth")
end

size(hs::HeirarchicalSoftmax) = size(hs.tree_vectors)