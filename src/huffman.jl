using DataStructures

struct HuffmanTree{M<:Integer, N<:Integer}
    nodeparent::AbstractArray{M}
    branch::AbstractArray{N}
end

function HuffmanTree(pq::PriorityQueue, vocab_hash::Dict)
    tmp_hash = copy(vocab_hash)

    # initialize return values
    asize = 2*length(tmp_hash)-1
    nodeparent = zeros(Int, asize)
    branch = zeros(Int, asize)

    # create nodes
    while length(pq) > 2
         _newnode!(pq, tmp_hash, nodeparent, branch)
    end
    _lastnode!(pq, tmp_hash, nodeparent, branch)

    return HuffmanTree(nodeparent, branch)
end

function _newnode!(pq::PriorityQueue, tmp_hash::Dict, nodeparent::Array, branch::Array)
    #create node ids
    (nodea, prioritya) = dequeue_pair!(pq)
    (nodeb, priorityb) = dequeue_pair!(pq)
    idxa = tmp_hash[nodea]
    idxb = tmp_hash[nodeb]

    #add a node to the graph
    idxnode = length(tmp_hash)+1
    prioritynode = prioritya + priorityb
    node = "node-$idxnode"
    tmp_hash[node] = idxnode

    #connect the child nodes to the new node
    nodeparent[idxa] = idxnode
    nodeparent[idxb] = idxnode

    #set the binary value for the child nodes
    branch[idxa] = 1
    branch[idxb] = 0

    #enqueue the new node
    enqueue!(pq, node, prioritynode)
end

function _lastnode!(pq::PriorityQueue, tmp_hash::Dict, nodeparent::Array, branch::Array)
    #create node ids
    (nodea, prioritya) = dequeue_pair!(pq)
    (nodeb, priorityb) = dequeue_pair!(pq)
    idxa = tmp_hash[nodea]
    idxb = tmp_hash[nodeb]

    #add a node to the graph
    idxnode = length(tmp_hash)+1
    node = "root"
    tmp_hash[node] = idxnode

    #connect the child nodes to the new node
    nodeparent[idxa] = idxnode
    nodeparent[idxb] = idxnode

    #set the binary value for the child nodes
    branch[idxa] = 1
    branch[idxb] = 0
end

# generate the path from leaf to root, normalized to the number of leaves
function normalizedpath(ht, vocab_hash, in_word)
    nodepath, branchpath = rootpath(wn.ht, wn.wv.vocab_hash, in_word)
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
