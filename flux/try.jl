using Flux, Flux.Tracker
using LinearAlgebra
using Flux.Tracker: update!

#define parameters
#10000 - 200 dimensional vecotrs
ov = param(randn(10000,200))

# define functions

# nodeprob
#probability you are going the right way at a node
# h = internal representation
# node = the current node number
# branch is the direction to branch from the node
function nodeprob(h, node, branch)
    v = ov[node,:]
    branch == 1 ? □ = 1 : □ = -1
    return σ(□*dot(v,h))
end

# takes a hidden represenntation, and a list of nodes and brnaches
#returns probability of that
function prob(h, nodes, branches)
    reduce(*, map((node, branch)->nodeprob(h, node, branch), nodes, branches))
end
loss(h, nodes, branches) = -log(prob(h, nodes, branches))

grad1 = Tracker.gradient(()->loss(h, nnode, bbranch), Params([ov]))

a = grad1[ov]


update!(ov, -0.1*a)
