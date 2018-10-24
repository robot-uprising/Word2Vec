

mutable struct W2VNetwork{S<:AbstractString, T<:Real, H<:Integer}
    wv::WordVectors{S,T,H} #WordVectors struct
    ht::HuffTree{H} #Huffman Tree struct
    ov::AbstractArray{T,2} #Output vectors
    vocab_size::H #I can't remember what this one means...
end

function W2VNetwork(doc, mincount::Integer, dims::Integer)
    @debug "Commencing network build"
    ht, vocab_hash = _createbinarytree(doc, mincount)
    @debug "generating inital vector states"
    vocab_size = length(vocab_hash)
    vocab = Array{String}(undef, vocab_size)
    for (i, j) in vocab_hash
        vocab[j] = i
    end
    wv = WordVectors(vocab, randn(dims, vocab_size), vocab_hash)
    return W2VNetwork(wv, ht, randn(vocab_size-1, dims), vocab_size)
end

function _forwardpass


end

function _normpath(wn::W2VNetwork, in_word::String)
    nodepath, branchpath = _rootpath(wn.ht, wn.wv.vocab_hash, in_word)
    nodepath = nodepath .- wn.vocab_size
    return nodepath, branchpath
end
