struct HuffTree{N<:Integer}
    nparent::AbstractArray{N} # parents for each node
    leftright::AbstractArray{N} # returns [[x]] for forward pass
end

function _rootpath(ht::HuffTree, vocab_hash::Dict, in_word::String)
    ret = Array{Int, 1}()
    leaf = vocab_hash[in_word]
    lparent = ht.nparent[leaf]
    lbin = ht.leftright[leaf]
    while lparent > 0
        push!(ret, lparent)
        push!(ret, lbin)
        lbin = ht.leftright[lparent]
        lparent = ht.nparent[lparent]
    end
    ret
end

function _createbinarytree(doc, mincount::Int)
    pq, vocab_hash = _makedicts(doc, mincount)
    tmp_hash = copy(vocab_hash)
    nparent, leftright = _binarytree!(pq, tmp_hash)
    return HuffTree(nparent, leftright), vocab_hash
end

function _binarytree!(pq::PriorityQueue, tmp_hash::Dict)
    @debug "creating Huffman tree"
    # initialize return values
    asize = 2*length(tmp_hash)-1
    nparent = zeros(Int, asize)
    leftright = zeros(Int, asize)
    # create nodes
    while length(pq) > 2
         _newnode!(pq, tmp_hash, nparent, leftright)
    end
    _lastnode!(pq, tmp_hash, nparent, leftright)
    return nparent, leftright
end

function _newnode!(pq::PriorityQueue, tmp_hash::Dict, nparent::Array, leftright::Array)
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
    nparent[idxa] = idxnode
    nparent[idxb] = idxnode

    #set the binary value for the child nodes
    leftright[idxa] = 1
    leftright[idxb] = -1

    #enqueue the new node
    enqueue!(pq, node, prioritynode)
end

function _lastnode!(pq, tmp_hash, nparent, leftright)
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
    nparent[idxa] = idxnode
    nparent[idxb] = idxnode

    #set the binary value for the child nodes
    leftright[idxa] = 1
    leftright[idxb] = -1
end
