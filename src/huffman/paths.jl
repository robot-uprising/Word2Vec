# generate the path from leaf to root, normalized to the number of leaves
function normalizedpath(ht, vocab_hash, in_word)
    nodepath, branchpath = rootpath(ht, vocab_hash, in_word)
    nodepath = nodepath .- length(vocab_hash)
    return nodepath, branchpath
end

# generate the path from leaf to root; because leaf nodes all have index less
# than internal nodes, the path is offset relative to 1 by the number of leaves
function rootpath(ht::HuffmanTree, vocab_hash::Dict, in_word::String)
    nodepath = Array{Int, 1}()
    branchpath = Array{Int, 1}()
    leaf = vocab_hash[in_word]
    lparent = ht.nodeparent[leaf]
    lbin = ht.branch[leaf]
    while lparent > 0
        push!(nodepath, lparent)
        push!(branchpath, lbin)
        lbin = ht.branch[lparent]
        lparent = ht.nodeparent[lparent]
    end
    return nodepath, branchpath
end
