using Flux, Flux.Tracker
using LinearAlgebra
using Flux.Tracker: update!

#define parameters
#10000 - 200 dimensional vecotrs
ov = param(randn(10000,200)/3)

# define functions

# nodeprob: returns probability you are going the right way at a node
# h = internal representation
# node = the current node number
# branch is the direction to branch from the node
# also requires a param(ov) (output vector) matrix
function nodeprob(h, node, branch)
    v = ov[node,:]
    branch == 1 ? □ = 1 : □ = -1
    return σ(□*dot(v,h))
end

# prob: returns probability(output word|input word)
# h = internal representation
# nodes = array of nodes in path to output word from Huffman tree
# branches = array of directions (0,1) to branch from each node in nodes
function prob(h, nodes, branches)
    reduce(*, map((node, branch)->nodeprob(h, node, branch), nodes, branches))
end

# loss is the -log of the probability(output word|input word)
loss(h, nodes, branches) = -log(prob(h, nodes, branches))

grad1 = Tracker.gradient(()->loss(h, nnode, bbranch), Params([ov]))

a = grad1[ov]


update!(ov, -0.1*a)
