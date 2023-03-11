using DataStructures

"""
    process_input(sentences, mincount, window)

Preprocessing function for input to be used in Word2Vec model.  Takes in an array of
tokenized sentences, an integer for the minimum word frequency, and the context
window size (one sided).

Returns a namedtuple containing a frequency table to use in downsampling, a vocabulary hash, a vocabulary
array, a PriorityQueue for constructing a HuffmanTree, and the data for Word2Vec
training.
"""
function process_input(sentences::Array{Array{T, 1}, 1}, mincount::Integer, window::Integer) where T <: AbstractString
    pq, freq_table, vocab_hash, vocab = _dicts(_unigrams(sentences), mincount)
    data = _data(sentences, window, vocab_hash, freq_table)
    return (freq_table = freq_table, vocab_hash = vocab_hash, vocab = vocab, pq = pq, data = data)
end

# Helper function to generate a set of unigrams to use for creating the data structures
function _unigrams(sentences::Array{Array{T, 1}, 1}) where T <: AbstractString
    unigrams = Dict{String, Integer}()
    for sentence in sentences
        for word in sentence
            in(word, keys(unigrams)) ? unigrams[word] += 1 : unigrams[word] = 1
        end
    end
    unigrams
end

# Helper function creates PriorityQueue for HuffmanTree, a frequency table for downsampling
# a vocabulary hash dictionary, and hashed vocabulary array
function _dicts(unigrams::Dict, mincount::Integer)
    vocab_hash = Dict{String, Int}()
    vocab = Array{Int, 1}()
    count_table = _dropmin(unigrams, mincount)
    for (i,j) in enumerate(count_table)
        (k,l) = j
        vocab_hash[k] = i
        push!(vocab, i)
    end
    hashed_table = Dict(vocab_hash[key]=>value for (key, value) in count_table)
    pq = PriorityQueue(hashed_table)
    vocab_size = sum(values(count_table))
    freq_table = Dict(vocab_hash[key]=>value/vocab_size for (key, value) in count_table)
    return pq, freq_table, vocab_hash, vocab
end

# drop out unigrams that don't meet the minimum count threshold and return a
# count table
function _dropmin(unigrams, mincount)
    count_table = Dict{String, Int}()
    for (i, j) in unigrams
        if j ≥ mincount
            count_table[i] = j
        else
            continue
        end
    end
    return count_table
end

# takes in array of sentences, returns an iterable TextData data object
# tokenized sentence in the doc
function _data(sentences::Array{Array{T, 1}, 1}, window::Integer, vocab_hash::Dict, freq_table::Dict) where T <: AbstractString
    data = word2vecdata(freq_table)
    for sentence in sentences
        if isempty(sentence)
            continue
        else
            dropmin_sentence = Int[]
            for word in sentence
                if in(word, keys(vocab_hash))
                    push!(dropmin_sentence, vocab_hash[word])
                else
                    continue
                end
            end
            if isempty(dropmin_sentence) || length(dropmin_sentence) == 1
                continue
            else
                push!(data, Context(window, dropmin_sentence))
            end
        end
    end
    return data
end
