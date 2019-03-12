using DataStructures

struct HuffmanTree{M<:Integer, N<:Integer}
    nodeparent::AbstractArray{M}
    branch::AbstractArray{N}
end

"""
    HuffmanTree(pq, vocab_hash)

Take in a PriorityQueue(pq) and a vocabulary hash, and return a Huffman encoding
of the words in pq.
"""
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
    node = "node-$idxnode" # for debugging
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
