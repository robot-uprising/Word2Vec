mutable struct WordVectors{S<:AbstractString, T<:Real, H<:Integer}
    vocab::AbstractArray{S, 1} # vocabulary
    vectors::AbstractArray{T, 2} # the vectors computed from word2vec
    vocab_hash::Dict{S, H}
end

function WordVectors(vocab::AbstractArray{S,1},
                    vectors::AbstractArray{T,2}) where {S <: AbstractString, T <: Real}
    length(vocab) == size(vectors, 2) ||
        throw(DimensionMismatch("Dimension of vocab and vectors are inconsistent."))
    vocab_hash = Dict{S, Int}()
    for (i, word) in enumerate(vocab)
        vocab_hash[word] = i
    end
    WordVectors(vocab, vectors, vocab_hash)
end

import Base: show, size

function Base.show(io::IO, wv::WordVectors)
    len_vecs, num_words = size(wv.vectors)
    print(io, "WordVectors $(num_words) words, $(len_vecs)-element vectors")
end

"""
    wordvectors(fname [,type=Float64][; kind=:text])

Generate a WordVectors type object from the file `fname`, where
`type` is the element of the vectors.
The file format can be either text (kind=`:text`) or
binary (kind=`:binary`).
"""
function wordvectors(fname::AbstractString, ::Type{T}; kind::Symbol=:text) where T <: Real
    if kind == :binary
        return _from_binary(fname) # only for Float32
    elseif kind == :text
        return _from_text(T, fname)
    else
        throw(ArgumentError("Unknown kind $(kind)"))
    end
end

wordvectors(frame::AbstractString; kind::Symbol=:text) =
    wordvectors(frame, Float64,kind=kind)

# generate a WordVectors object from binary file
function _from_binary(filename::AbstractString)
    open(filename) do f
        header = strip(readline(f))
        vocab_size,vector_size = map(x -> parse(Int, x), split(header, ' '))
        vocab = Vector{AbstractString}(vocab_size)
        vectors = Array{Float32}(vector_size, vocab_size)
        binary_length = sizeof(Float32) * vector_size
        for i in 1:vocab_size
            vocab[i] = strip(readuntil(f, ' '))
            vector = read(f, Float32, vector_size)
            vec_norm = norm(vector)
            vectors[:, i] = vector./vec_norm  # unit vector
            read(f, UInt8) # new line
        end
        return WordVectors(vocab, vectors)
    end
end

# generate a WordVectors object from text file
function _from_text(::Type{T}, filename::AbstractString) where T
    open(filename) do f
        header = strip(readline(f))
        vocab_size,vector_size = map(x -> parse(Int, x), split(header, ' '))
        vocab = Vector{AbstractString}(vocab_size)
        vectors = Array{T}(vector_size, vocab_size)
        @inbounds for (i, line) in enumerate(readlines(f))
            #println(line)
            line = strip(line)
            parts = split(line, ' ')
            word = parts[1]
            vector = map(x-> parse(T, x), parts[2:end])
            vec_norm = norm(vector)
            vocab[i] = word
            vectors[:, i] = vector./vec_norm  #unit vector
        end
       return WordVectors(vocab, vectors)
    end
end
