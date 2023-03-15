using DataStructures: PriorityQueue

struct HeirarchicalSoftmax{A<:AbstractArray{<:AbstractFloat, 2}, B<:AbstractArray{<:AbstractArray{<:Integer, 1}}}
    weights::A
    nodepaths::B
    branchpaths::B
end

"""
    init_softmax(pq::PriorityQueue, vocab_hash::Dict, vocab::Array)

TBW
"""
function init_softmax(vector_size::Int, pq::PriorityQueue, vocab_hash::Dict, vocab::Array)
    return HeirarchicalSoftmax(randn(vector_size, length(vocab)), allpaths(HuffmanTree(pq, vocab_hash), vocab_hash, vocab)...)
end


import Base: show, size

function Base.show(io::IO, hs::HeirarchicalSoftmax)
    max_depth = maximum(length.(hs.branchpaths))
    print(io, "HeirarchicalSoftmax with a Huffman tree of depth $max_depth")
end

size(hs::HeirarchicalSoftmax) = size(hs.tree_vectors)
