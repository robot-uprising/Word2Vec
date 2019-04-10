using Statistics

struct WordVectors{A<:AbstractArray{<:AbstractFloat, 2}, B<:AbstractArray{<:AbstractString, 1}, C<:AbstractDict{<:AbstractString, <:Integer}}
    vectors::A # the vectors computed from word2vec
    vocab::B # id to vocab
    vocab_hash::C # vocabulary to id
end

function WordVectors(wordvector_dims::Integer, vocab::AbstractArray, vocab_hash)
    return WordVectors(randn(length(vocab), wordvector_dims), vocab, vocab_hash)
end

(layer::WordVectors)(x::Integer, y::Integer) = layer.vectors[x, :]

(layer::WordVectors)(x::AbstractArray{<:Integer, 1}, y::Integer) = mean([layer.vectors[i, :] for i in x])

(layer::WordVectors)(xs::AbstractArray, ys::AbstractArray) = map((x, y) -> layer(x, y), xs, ys)


import Base: show, size

function Base.show(io::IO, wv::WordVectors)
    len_vecs, num_words = size(wv.vectors)
    print(io, "WordVectors $(num_words) words, $(len_vecs)-element vectors")
end
