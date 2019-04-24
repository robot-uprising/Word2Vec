using Flux: param

struct WordVectors{A<:AbstractArray{<:AbstractFloat, 2}, B<:AbstractArray{<:AbstractString, 1}, C<:AbstractDict{<:AbstractString, <:Integer}}
    vectors::A # the vectors computed from word2vec
    vocab::B # id to vocab
    vocab_hash::C # vocabulary to id
end

function WordVectors(wordvector_dims::Integer, vocab::AbstractArray, vocab_hash)
    return WordVectors(param(randn(wordvector_dims, length(vocab))), vocab, vocab_hash)
end

(layer::WordVectors)(x::Integer, y::Integer) = layer.vectors[x, :], y

(layer::WordVectors)(x::AbstractArray{<:Real, 1}, y::Integer) = layer.vectors*x, y

(layer::WordVectors)(x::AbstractArray{<:Real, 2}, y::AbstractArray{<:Real, 1}) = layer.vectors*x, y

(layer::WordVectors)(data::Tuple) = layer(data...)


import Base: show, size

function Base.show(io::IO, wv::WordVectors)
    len_vecs, num_words = size(wv.vectors)
    print(io, "WordVectors $(num_words) words, $(len_vecs)-element vectors")
end

"""
    size(wv)

Return the word vector length and the number of words as a tuple.
"""
size(wv::WordVectors) = size(wv.vectors)

"""
    vocabulary(wv)

Return the vocabulary as a vector of words of the WordVectors `wv`.
"""
vocabulary(wv::WordVectors) = wv.vocab

"""
    in_vocabulary(wv, word)

Return `true` if `word` is part of the vocabulary of the WordVector `wv` and
`false` otherwise.
"""
in_vocabulary(wv::WordVectors, word) = word in wv.vocab


"""
    index(wv, word)

Return the index of `word` from the WordVectors `wv`.
"""
index(wv::WordVectors, word) = wv.vocab_hash[word]


"""
    get_vector(wv, word)

Return the vector representation of `word` from the WordVectors `wv`.
"""
get_vector(wv::WordVectors, word) =
      (idx = wv.vocab_hash[word]; wv.vectors[:,idx])


"""
    cosine(wv, word, n=10)

Return the position of `n` (by default `n = 10`) neighbors of `word` and their
cosine similarities.
"""
function cosine(wv::WordVectors, word, n=10)
    metrics = wv.vectors'*get_vector(wv, word)
    topn_positions = sortperm(metrics[:], rev = true)[1:n]
    topn_metrics = metrics[topn_positions]
    return topn_positions, topn_metrics
end


"""
    similarity(wv, word1, word2)

Return the cosine similarity value between two words `word1` and `word2`.
"""
function similarity(wv::WordVectors, word1, word2)
    return get_vector(wv, word1)'*get_vector(wv, word2)
end


"""
    cosine_similar_words(wv, word, n=10)

Return the top `n` (by default `n = 10`) most similar words to `word`
from the WordVectors `wv`.
"""
function cosine_similar_words(wv::WordVectors, word, n=10)
    indx, metr = cosine(wv, word, n)
    return vocabulary(wv)[indx]
end


"""
    analogy(wv, pos, neg, n=5)

Compute the analogy similarity between two lists of words. The positions
and the similarity values of the top `n` similar words will be returned.
For example,
`king - man + woman = queen` will be
`pos=[\"king\", \"woman\"], neg=[\"man\"]`.
"""
function analogy(wv::WordVectors, pos::AbstractArray, neg::AbstractArray, n= 5)
    m, n_vocab = size(wv)
    n_pos = length(pos)
    n_neg = length(neg)
    anal_vecs = Array{AbstractFloat}(m, n_pos + n_neg)

    for (i, word) in enumerate(pos)
        anal_vecs[:,i] = get_vector(wv, word)
    end
    for (i, word) in enumerate(neg)
        anal_vecs[:,i+n_pos] = -get_vector(wv, word)
    end
    mean_vec = mean(anal_vecs, 2)
    metrics = wv.vectors'*mean_vec
    top_positions = sortperm(metrics[:], rev = true)[1:n+n_pos+n_neg]
    for word in [pos;neg]
        idx = index(wv, word)
        loc = findfirst(top_positions, idx)
        if loc != 0
            splice!(top_positions, loc)
        end
    end
    topn_positions = top_positions[1:n]
    topn_metrics = metrics[topn_positions]
    return topn_positions, topn_metrics
end


"""
    analogy_words(wv, pos, neg, n=5)

Return the top `n` words computed by analogy similarity between
positive words `pos` and negaive words `neg`. from the WordVectors `wv`.
"""
function analogy_words(wv::WordVectors, pos, neg, n=5)
    indx, metr = analogy(wv, pos, neg, n)
    return vocabulary(wv)[indx]
end
