#take in an array of strings representing sentences, and return ngrams
include("../inputprocessing.jl")

flags = strip_corrupt_utf8 | strip_case | strip_whitespace | strip_html_tags


a = "./data/shakespeare.txt"

doc = StringDocument(text(FileDocument(a)))
prepare!(doc, flags)
eightgrams = ngrams(doc, 8)
ngrms = ngrams(doc)
pq, vocab_hash, drop_words = _dicts(ngrms, 2)

flagsint = strip_corrupt_utf8 | strip_case | strip_whitespace
