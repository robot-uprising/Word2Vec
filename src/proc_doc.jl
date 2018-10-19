using TextAnalysis
using DataStructures

struct Node
    name::String
    binary::String
    up::Int
    down::Vector{Int}
end

function Node(name::String)
    Node(name, "", 0, [0,0])
end

function makedicts(path::AbstractString, mincount::Int)
    ngd = ngrams(FileDocument(path))
    ret = _makedicts(ngd, mincount)
    ret
end

function makedicts(doc::AbstractDocument, mincount::Int)
    ngd = ngrams(doc)
    ret = _makedicts(ngd, mincount)
    ret
end

function _makedicts(ngd::Dict, mincount::Int)
    lexicn = _dropmin(ngd, mincount)
    pq = PriorityQueue(lexicn)
    w2id = Dict{String, Int}()
    id2w = Dict{Int, String}()
    for (i,j) in enumerate(pq)
        (k,l) = j
        w2id[k] = i
        id2w[i] = k
    end
    (pq, lexicn, w2id, id2w)
end

function _dropmin(ngd, mincount)
    lexicn = Dict{String, Int}()
    for (i, j) in ngd
        if j > mincount
            lexicn[i] = j
        else
            continue
        end
    end
    return lexicn
end
