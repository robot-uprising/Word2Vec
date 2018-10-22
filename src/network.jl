mutable struct W2VNetwork{S<:AbstractString, T<:Real, H<:Integer}
    wv::WordVectors{S,T,H} #WordVectors struct
    ht::HuffTree{H} #Huffman Tree struct
    ov::AbstractArray{T,2} #Out put vectors
    vocab_size::H
end

function W2VNetwork(doc, mincount::Integer, dims::Integer)
    @debug "Commencing network build"
    ht, vocab_hash = createbinarytree(doc, mincount)
    @debug "generating inital vector states"
    vocab_size = length(vocab_hash)
    vocab = Array{String}(undef, vocab_size)
    for (i, j) in vocab_hash
        vocab[j] = i
    end
    wv = WordVectors(vocab, randn(dims, vocab_size), vocab_hash)
    ov = randn()
    return W2VNetwork(wv, ht, randn(vocab_size-1, dims), vocab_size)
end

function
doc = "..\\data\\shakespeare.txt"
network = W2VNetwork(doc, 10, 300)
