# if a file name is provided as String
function createbinarytree(path::AbstractString, mincount::Int)
    return _createbinarytree(makedicts(path, mincount)...)
end

# if a TextAnalysis type document is provided
function createbinarytree(doc::AbstractDocument, mincount::Int)
    return _createbinarytree(makedicts(doc, mincount)...)
end

function _createbinarytree(pq::PriorityQueue, w2id::Dict{String, Int}, id2w::Dict{Int, String})
    mg = MetaGraph(SimpleGraph(length(pq)))
    while length(pq) > 1
         _newnode!(mg, pq, w2id, id2w)
    end
    idxroot = nv(mg)
    w2id["root"] = idxroot
    id2w[idxroot] = "root"
    (mg, w2id, id2w)
end

function _newnode!(mg::MetaGraph, pq::PriorityQueue, w2id::Dict{String, Int}, id2w::Dict{Int, String})
    #capture information about next two nodes
    (nodea, prioritya) = dequeue_pair!(pq)
    (nodeb, priorityb) = dequeue_pair!(pq)
    idxa = w2id[nodea]
    idxb = w2id[nodeb]

    #add a node to the graph
    add_vertex!(mg)
    idxnode = nv(mg)
    prioritynode = prioritya + priorityb
    prioritynode
    node = "node-$idxnode"
    w2id[node] = idxnode
    id2w[idxnode] = node

    #connect the child nodes to the new node
    add_edge!(mg, idxa, idxnode)
    add_edge!(mg, idxb, idxnode)

    #set the binary value for the child nodes
    set_prop!(mg, idxa, :bin, 0)
    set_prop!(mg, idxb, :bin, 1)

    #enqueue the new node
    enqueue!(pq, node, prioritynode)
end
