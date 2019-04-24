using DataStructures: PriorityQueue
using LinearAlgebra: dot
using NNlib: σ
using Statistics: mean
using Flux: param

struct HeirarchicalSoftmax{A<:AbstractArray{<:AbstractFloat, 2}, B<:AbstractArray{<:AbstractArray{<:Integer, 1}}}
    tree_vectors::A
    nodepaths::B
    branchpaths::B
end

function HeirarchicalSoftmax(wordvector_dims::Int, pq::PriorityQueue, vocab_hash::Dict, vocab::Array)
    return HeirarchicalSoftmax(param(randn(length(keys(vocab_hash)), wordvector_dims)), allpaths(HuffmanTree(pq, vocab_hash), vocab_hash, vocab)...)
end

function (layer::HeirarchicalSoftmax)(hiddenvector::AbstractArray{<:AbstractFloat, 1}, outputword::Integer)
    reduce(*, map((node, branch)->(_nodeprob(hiddenvector, layer.tree_vectors, node, branch)), layer.nodepaths[outputword], layer.branchpaths[outputword]))
end

function (layer::HeirarchicalSoftmax)(hiddenvectors::AbstractArray{<:AbstractFloat, 2}, outputwords::AbstractArray{<:Integer, 1})
    p = []
    size(hiddenvectors)[2] ≠ length(outputwords) ? error("X and y batch sizes do not match") : nothing
    for i in 1:length(outputwords)
        hiddenvector = hiddenvectors[:, i]
        outputword = outputwords[i]
        push!(p, reduce(*, map((node, branch)->(_nodeprob(hiddenvector, layer.tree_vectors, node, branch)), layer.nodepaths[outputword], layer.branchpaths[outputword])))
    end
    return mean(p)
end

(layer::HeirarchicalSoftmax)(incoming::Tuple) = layer(incoming...)

function _nodeprob(hiddenvector, tree_vectors, node, branch)
    branch == 1 ? ◫ = 1 : ◫ = -1
    return σ(◫*dot(tree_vectors[node,:],hiddenvector))
end
