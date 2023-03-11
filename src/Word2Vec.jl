module Word2Vec

using Reexport

include("./doctools/tokenize.jl")
export tokenize_document

include("inputprocessing.jl")
export process_input

include("huffman/Huffman.jl")
@reexport using .Huffman

include("contextdata/ContextDataTypes.jl")
@reexport using .ContextDataTypes

include("train.jl")
export train

include("wordvectors.jl")
export
    # types
    WordVectors,

    # functions
    init_vectors,
    index, size,
    vocabulary, in_vocabulary,
    get_vector, cosine, cosine_similar_words,
    analogy, analogy_words, similarity


include("interface.jl")
    export init_model

end
