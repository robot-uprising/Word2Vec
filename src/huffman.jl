# if a file name is provided as String
function createbinarytree(path::AbstractString, mincount::Int)
    pq, n2id, id2n = makedicts(path, mincount)
    id2w = copy(id2n)
    w2id = copy(n2id)
    mg = _createbinarytree(pq, n2id, id2n)
    (mg, w2id, id2w)
end

# if a TextAnalysis type document is provided
function createbinarytree(doc::AbstractDocument, mincount::Int)
    pq, n2id, id2n = makedicts(doc, mincount)
    id2w = copy(id2n)
    w2id = copy(n2id)
    mg = _createbinarytree(pq, n2id, id2n)
    (mg, w2id, id2w)
end
#if a TextAnalysis Corpus is provided
function createbinarytree(crps::Corpus, mincount::Int)
    if length(crps.lexicon) == 0
        update_lexicon!(crps)
    end
    pq, n2id, id2n = makedicts(crps, mincount)
    id2w = copy(id2n)
    w2id = copy(n2id)
    mg = _createbinarytree(pq, n2id, id2n)
    (mg, w2id, id2w)
end

function _createbinarytree(pq::PriorityQueue, w2id::Dict{String, Int}, id2w::Dict{Int, String})
    mg = MetaGraph(SimpleGraph(length(pq)))

    #create nodes
    while length(pq) > 1
         _newnode!(mg, pq, w2id, id2w)
    end

    mg
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
