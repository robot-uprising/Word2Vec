using DataStructures: PriorityQueue

struct HeirarchicalSoftmax{A<:AbstractArray{<:AbstractFloat, 2}, B<:AbstractArray{<:AbstractArray{<:Integer, 1}}}
    tree_vectors::A
    nodepaths::B
    branchpaths::B
end

function HeirarchicalSoftmax(wordvector_dims::Int, pq::PriorityQueue, vocab_hash::Dict, vocab::Array)
    return HeirarchicalSoftmax(randn(length(keys(vocab_hash)), wordvector_dims), allpaths(HuffmanTree(pq, vocab_hash), vocab_hash, vocab)...)
end


import Base: show, size

function Base.show(io::IO, hs::HeirarchicalSoftmax)
    max_depth = maximum(length.(hs.branchpaths))
    print(io, "HeirarchicalSoftmax with a Huffman tree of depth $max_depth")
end

size(hs::HeirarchicalSoftmax) = size(hs.tree_vectors)
