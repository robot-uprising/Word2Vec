# HuffTree binary tree struct
#     nodeparent::AbstractArray -- Each array index representing a node
#         of the Huffman tree.  The value at each index represents the
#         parent node of the index node.
#     branch::AbstractArray --  Each array index representing a node
#         of the Huffman tree.  The value at each index represents whether
#         the index node branched left (-1) or right (1) from the parent
#         node.

struct HuffTree{N<:Integer}
    nodeparent::AbstractArray{N}
    branch::AbstractArray{N}
end

# _rootpath function determines the path from a given node of a HuffTree
#     to the root node of the tree

function _rootpath(ht::HuffTree, vocab_hash::Dict, in_word::String)
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

# _createbinarytree uses accessory functions _binarytree, _newnode! and _lastnode!
#     to generate a Huffman tree
function _createbinarytree(doc, mincount::Int)
    pq, vocab_hash = _makedicts(doc, mincount)
    tmp_hash = copy(vocab_hash)
    nodeparent, branch = _binarytree(pq, tmp_hash)
    return HuffTree(nodeparent, branch), vocab_hash
end

function _binarytree(pq::PriorityQueue, tmp_hash::Dict)
    @debug "creating Huffman tree"
    # initialize return values
    asize = 2*length(tmp_hash)-1
    nodeparent = zeros(Int, asize)
    branch = zeros(Int, asize)
    # create nodes
    while length(pq) > 2
         _newnode!(pq, tmp_hash, nodeparent, branch)
    end
    _lastnode!(pq, tmp_hash, nodeparent, branch)
    return nodeparent, branch
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
    branch[idxb] = -1

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
    branch[idxb] = -1
end
