using DataStructures: PriorityQueue
using LinearAlgebra: dot
using NNlib: σ

struct HeirarchicalSoftmax{A<:AbstractArray{<:AbstractFloat, 2}, B<:AbstractArray{<:AbstractArray{<:Integer, 1}}}
    tree_vectors::A
    nodepaths::B
    branchpaths::B
end

function HeirarchicalSoftmax(wordvector_dims::Int, pq::PriorityQueue, vocab_hash::Dict, vocab::Array)
    return HeirarchicalSoftmax(randn(length(vocab), wordvector_dims), allpaths(HuffmanTree(pq, vocab_hash), vocab_hash, vocab))
end

(layer::HeirarchicalSoftmax)(wordvector, outputword) = reduce(*, map((node, branch)->(_nodeprob(wordvector, layer.tree_vectors, node, branch)), layer.nodepaths[outputword], layer.branchpaths[outputword]))

function _nodeprob(wordvector, tree_vectors, node, branch)
    branch == 1 ? ◫ = 1 : ◫ = -1
    return σ(◫*dot(tree_vectors[node,:],wordvector))
end
