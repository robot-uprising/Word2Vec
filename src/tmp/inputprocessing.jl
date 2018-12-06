# if a file name is provided as String
function _makedicts(path::AbstractString, mincount::Int)
    return _dicts(ngrams(FileDocument(path)), mincount)
end

# if a TextAnalysis type document is provided
function _makedicts(doc::AbstractDocument, mincount::Int)
    return _dicts(ngrams(doc), mincount)
end

# if a TextAnalysis Corpus is provided
function _makedicts(crps::Corpus, mincount::Int)
    if length(crps.lexicon) == 0
        update_lexicon!(crps)
    end
    return _dicts(crps.lexicon, mincount)
end
