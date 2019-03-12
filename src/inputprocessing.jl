using IterTools
using DataStructures

#sentences is an array of sentences to be parsed
#preprocessing should provide this array from the document
function _process_input(sentences::Array{Array{AbstractString, 1},1}, mincount::Integer, window::Integer)
    unigrams = _unigrams(sentences)
    freq_table, vocab_hash = _dicts(unigrams, mincount)
    pq = PriorityQueue(freq_table)
    # function to remove dropped words - add vocab hash to context function
    contexts = _contexts(sentences, window)
    return pq, vocab_hash, contexts, unigrams
end

function _unigrams(sentences::Array{Array{AbstractString, 1},1})
    unigrams = Dict{String, Integer}()
    for sentence in sentences
        for word in sentence
            in(word, keys(unigrams)) ? unigrams[word] += 1 : unigrams[word] = 1
        end
    end
    unigrams
end

# takes in array of sentences, returns an IterTools.Partition for each sentence
# in the doc
function _contexts(sentences::Array{Array{AbstractString,1},1}, window::Integer)
    size = window*2+1
    contexts = Array{IterTools.Partition, 1}()
    for sentence in sentences
        if isempty(sentence)
            continue
        else
            length(sentence) ≥ size ? context = partition(sentence, size, 1) : context = partition(sentence, length(sentence), 1)
            push!(contexts, context)
        end
    end
    return contexts
end

# creates PriorityQueue for HuffmanTree, as well as vocabulary hash dict, and drop words array
function _dicts(unigrams::Dict, mincount::Int)
    freq_table = _dropmin(unigrams, mincount)
    vocab_hash = Dict{String, Int}()
    for (i,j) in enumerate(freq_table)
        (k,l) = j
        vocab_hash[k] = i
    end
    return freq_table, vocab_hash
end

function _dropmin(unigrams, mincount)
    freq_table = Dict{String, Int}()
    for (i, j) in unigrams
        if j ≥ mincount
            freq_table[i] = j
        else
            continue
        end
    end
    return freq_table
end
