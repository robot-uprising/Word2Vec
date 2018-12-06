mutable struct W2VNetwork{S<:AbstractString, T<:Real, H<:Integer}
    wv::WordVectors{S,T,H} #WordVectors struct
    ht::Union{HuffmanTree{H}, Nothing} #Huffman Tree struct
    ov::Union{AbstractArray{T,2}, Nothing} #Output vectors
    #frequency table???
end

# fix this so we just word with array vocab
function W2VNetwork(ht::HuffmanTree, vocab_hash::Dict, dims::Integer)
    vocab_size = length(vocab_hash)
    vocab = Array{String}(undef, vocab_size)
    for (i, j) in vocab_hash
        vocab[j] = i
    end
    wv = WordVectors(vocab, randn(dims, vocab_size), vocab_hash)
    return W2VNetwork(wv, ht, randn(vocab_size-1, dims), vocab_size)
end

function dump_model!(wn::W2VNetwork)
    wn.ht = nothing
    wn.ov = nothing
end

function extract_vectors(wn::W2VNetwork)
    return wn.wv
end

function extract_vectors!(wn:W2W2VNetwork)
    wv = copy(wn.wv)
    wn = nothing
    return wv
end

# need to implement
# maybe the word2vec stuff in a separate file
#     word2vec - initializes and trains as directed
#         train! - in place update of wieghts
#             needs to be different based on :skipgram or :cbow
#             also needs to be different for :hs or :ns
#
#     extract_vectors - returns wordvectors
#     dump_model! - sets everything to nothing except the wordvectors
