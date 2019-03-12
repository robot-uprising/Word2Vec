using WordTokenizers

"""
    tokenize_document(path)

Helper function to prepare a text file for Word2Vec.  Takes in a filesystem path
as a String and returns an Array of tokenized sentences.
"""
function tokenize_document(path::String)
    tokenized = open(path) do file
        text = replace(read(file, String), r"\n+|\r+|\s+" => " ")
        sentences = tokenize.(split_sentences(text))
        tokenized = Array{Array{AbstractString, 1}, 1}()
        for sentence in sentences
            no_punct = Array{AbstractString, 1}()
            for word in sentence
                occursin(r"[!\"#$%&\'()*+,-./:;<=>?@\[\\\]^_`\{\|\}~]+", word) ?
                                                continue : push!(no_punct, word)
            end
            push!(tokenized, lowercase.(no_punct))
        end
        tokenized
    end
    return tokenized
end
