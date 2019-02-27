module Word2Vec

using Reexport
# using IterTools
# using DataStructures
# using LinearAlgebra

include("huffman/Huffman.jl")

@reexport using .Huffman

#
# include("inputprocessing.jl")
#
#
# include("wordvectors.jl")
# export
#     # types
#     WordVectors,
#
#     # functions
#     wordvectors
#
# include("network.jl")
# export
#     # types
#     W2VNetwork,
#
#     # functions
#     word2vec, train!, extract_vectors! # still need to be implemented
#
# include("vectorinteract.jl")
#     export
#     # functions
#     index, size,
#     vocabulary, in_vocabulary,
#     get_vector, get_cluster, get_words,
#     cosine, cosine_similar_words,
#     analogy, analogy_words, similarity

end
