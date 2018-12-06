using IterTools
using DataStructures

#sentences is an array of sentences to be parsed
#preprecessing should provide this array from the document
function process_input(sentences::Array{<:AbstractString,1}, mincount::Integer, window::Integer)
    unigrms = _unigrams(sentences)
    freq_table, vocab_hash = _dicts(unigrms, mincount)
    pq = PriorityQueue(freq_table)
    # function to remove dropped words - add vocab hash to context function
    contexts = _contexts(sentences, vocab_hash, window)
    return pq, vocab_hash, contexts, unigrms
end

function _unigrams(sentences::Array{<:AbstractString, 1})
    unigrms = Dict{String, Integer}()
    for sentence in sentences
        words = split(sentence)
        for word in words
            in(word, keys(unigrms)) ? unigrms[word] += 1 : unigrms[word] = 1
        end
    end
    unigrms
end

# takes in array of sentences, returns an IterTools.Partition for each sentence
# in the doc
function _contexts(sentences::Array{<:AbstractString, 1}, vocab_hash::Dict, window::Integer)
    size = window*2+1
    contexts = Array{IterTools.Partition, 1}()
    for sentence in sentences
        words = Array{AbstractString, 1}()
        tmp = split(sentence)
        for word in tmp
            in(word, keys(vocab_hash)) ? push!(words, word) : continue
        end
        length(words) ≥ size ? context = partition(words, size, 1) : context = partition(words, length(words), 1)
        push!(contexts, context)
        end
    return contexts
end

# creates PriorityQueue for HuffmanTree, as well as vocabulary hash dict, and drop words array
function _dicts(ngd::Dict, mincount::Int)
    freq_table = _dropmin(ngd, mincount)
        vocab_hash = Dict{String, Int}()
        for (i,j) in enumerate(freq_table)
        (k,l) = j
        vocab_hash[k] = i
    end
    return freq_table, vocab_hash
end

function _dropmin(ngd, mincount)
    freq_table = Dict{String, Int}()
    for (i, j) in ngd
        if j ≥ mincount
            freq_table[i] = j
        else
            continue
        end
    end
    return freq_table
end
