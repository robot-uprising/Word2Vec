using TextAnalysis

# if a file name is provided as String
function makedicts(path::AbstractString, mincount::Int)
    return _makedicts(ngrams(FileDocument(path)), mincount)
end

# if a TextAnalysis type document is provided
function makedicts(doc::AbstractDocument, mincount::Int)
    return _makedicts(ngrams(doc), mincount)
end

# if a TextAnalysis Corpus is provided
function makedicts(crps::Corpus, mincount::Int)
    if length(crps.lexicon) == 0
        update_lexicon!(crps)
    end
    return _makedicts(crps.lexicon, mincount)
end

function _makedicts(ngd::Dict, mincount::Int)
    pq = PriorityQueue(_dropmin(ngd, mincount))
    vocab_hash = Dict{String, Int}()
        for (i,j) in enumerate(pq)
        (k,l) = j
        vocab_hash[k] = i
    end
    return pq, vocab_hash
end

function _dropmin(ngd, mincount)
    words_counts = Dict{String, Int}()
    for (i, j) in ngd
        if j > mincount
            words_counts[i] = j
        else
            continue
        end
    end
    return words_counts
end
