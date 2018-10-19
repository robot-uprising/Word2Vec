using DataStructures
using TextAnalysis

function createbinarytree(sd::StringDocument, mincount::Int = 5)
    (pq, lexicn, w2id, id2w) = _makedicts(sd, mincount)
    g = SimpleGraph(length(pq))
    while length(pq) >1
    _newnode(g, pq, w2id, id2w)
    end
    idxroot = nv(g)
    w2id["root"] = idxroot
    id2w[idxroot] = "root"
    (g, lexicn, w2id, id2w)
end

function _newnode(g::SimpleGraph, pq::PriorityQueue, w2id::Dict{String, Int}, id2w::Dict{Int, String})
    #capture information about next two nodes
    (worda, prioritya) = dequeue_pair!(pq)
    (wordb, priorityb) = dequeue_pair!(pq)
    idxa = w2id[worda]
    idxb = w2id[wordb]
    #add a node to the graph
    add_vertex!(g)
    idxnode = nv(g)
    prioritynode = prioritya + priorityb
    node = "node-$idxnode"
    w2id[node] = idxnode
    id2w[idxnode] = node
    #connect the incoming nodes to the new nodes
    add_edge!(g, idxa, idxnode)
    add_edge!(g, idxb, idxnode)
    #enqueue the new node
    enqueue!(pq, node, prioritynode)
end
