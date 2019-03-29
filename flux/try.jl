using Flux, Flux.Tracker
using LinearAlgebra
using Flux.Tracker: update!

#define parameters
#10000 - 200 dimensional vecotrs
ov = param(randn(10000,200)/3)

# define functions

# nodeprob: returns probability you are going the right way at a node
# ov = the output vector matrix a Flux param
# h = internal representation
# node = the current node number
# branch is the direction to branch from the node
function nodeprob(ov, h, node, branch)
    v = ov[node,:]
    branch == 1 ? ◫ = 1 : ◫ = -1
    return σ(◫*dot(v,h))
end

# prob: returns probability(output word|input word)
# h = internal representation
# nodes = array of nodes in path to output word from Huffman tree
# branches = array of directions (0,1) to branch from each node in nodes
function prob(ov, h, nodes, branches)
    e = reduce(*, map((node, branch)->(nodeprob(ov, h, node, branch)), nodes, branches))
end

# loss is the -log of the probability(output word|input word)
loss1(ov, h, nodes, branches) = -1*log(prob(ov, h, nodes, branches))
loss2(ov, h, nodes, branches) = -1*reduce(+, map((node, branch)->log((nodeprob(ov, h, node, branch))), nodes, branches))


# try it out
h = param(randn(200)/3)
nodes = [200,300,400,500]
branches = [0,0,1,0]

for i in 1:30
    println(loss1(ov, h, nodes, branches))
    grad1 = Tracker.gradient(()->loss1(ov, h, nodes, branches), Params([ov]))
    a = grad1[ov]
    update!(ov, -0.1*a)
end
