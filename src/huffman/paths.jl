"""
    normalizedpath(ht, vocab_hash, in_word)

Generate the path through a Huffman encoding for in_word.  Returns nodepath
(the series of nodes from the root of the Huffman tree
to the word leaf), and branchpath (the binary representation of whether to
branch left or right from the node).
"""
function normalizedpath(ht::HuffmanTree, vocab_hash::Dict, in_word::String)
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
    allpaths(ht, vocab_hash, vocab)

Generate all paths through a Huffman encoding for every word in a vocabulary
hash, by using a vocabulary array.  Returns nodepaths (the series of nodes
from the root of the Huffman tree to the word leaf), and branchpaths (the binary
representation of whether to branch left or right from the node).
"""
function allpaths(ht::HuffmanTree, vocab_hash::Dict, vocab::Array)
    nodepaths = Array{Array{Int, 1}, 1}()
    branchpaths = Array{Array{Int, 1}, 1}()
    for key in 1:length(vocab_hash)
        wordnodes, wordbranches = normalizedpath(ht, vocab_hash, vocab[key])
        push!(nodepaths, wordnodes)
        push!(branchpaths, wordbranches)
    end
    return nodepaths, branchpaths
end
