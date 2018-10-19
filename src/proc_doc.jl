# if a file name is provided as String
function makedicts(path::AbstractString, mincount::Int)
    return _makedicts(ngrams(FileDocument(path)), mincount)
end

# if a TextAnalysis type document is provided
function makedicts(doc::AbstractDocument, mincount::Int)
    return _makedicts(ngrams(doc), mincount)
end

function makedicts(crps::Corpus, mincount::Int)
    return _makedicts(crps.lexicon, mincount)
end

function _makedicts(ngd::Dict, mincount::Int)
    pq = PriorityQueue(_dropmin(ngd, mincount))
    w2id = Dict{String, Int}()
    id2w = Dict{Int, String}()
    for (i,j) in enumerate(pq)
        (k,l) = j
        w2id[k] = i
        id2w[i] = k
    end
    (pq, w2id, id2w)
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
