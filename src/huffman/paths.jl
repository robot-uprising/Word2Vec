# generate the path from leaf to root, normalized to the number of leaves
function _normalizedpath(ht, vocab_hash, in_word)
    nodepath, branchpath = _rootpath(ht, vocab_hash, in_word)
    nodepath = nodepath .- length(vocab_hash)
    return nodepath, branchpath
end

# generate the path from leaf to root; because leaf nodes all have index less
# than internal nodes, the path is offset relative to 1 by the number of leaves
function _rootpath(ht::HuffmanTree, vocab_hash::Dict, in_word::String)
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

"""
    allpahts(ht, vocab_hash)

Generate all paths through a Huffman encoding for every word in a vocabulary
hash.  Returns nodepaths (the series of nodes from the root of the Huffman tree
to the word leaf), and branchpaths (the binary representation of whether to
branch left or right from the node).
"""
function allpaths(ht::HuffmanTree, vocab_hash::Dict)
    nodepaths = Array{Array{Int, 1}, 1}()
    branchpaths = Array{Array{Int, 1}, 1}()
    for key in 1:length(vocab_hash)
        id2word = Dict([vocab_hash[word] => word for word in keys(vocab_hash)])
        wordnodes, wordbranches = _normalizedpath(ht, vocab_hash, id2word[key])
        push!(nodepaths, wordnodes)
        push!(branchpaths, wordbranches)
    end
    return nodepaths, branchpaths
end
