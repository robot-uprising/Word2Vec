using Flux, Flux.Tracker
using LinearAlgebra
using Flux.Tracker: update!
using Word2Vec

sentences = tokenize_document("./data/shakespeare_all.txt")

vocab_hash, vocab, pq, data = process_input(sentences, 3, 5, :cbow)

data = minibatch(data, 500)

wv = WordVectors(25, vocab, vocab_hash)

hs = HeirarchicalSoftmax(25, pq, vocab_hash, vocab)

loss(z) = -1*log(hs(wv(z...)))

ps = params(hs.tree_vectors, wv.vectors)

using ProgressMeter

@showprogress 1 for i in data
        l = loss(i)
        #println(l)
        grad1 = Tracker.gradient(()->l, ps)
        a = grad1[hs.tree_vectors]
        b = grad1[wv.vectors]
        update!(hs.tree_vectors, -0.1*a)
        update!(wv.vectors, -0.1*b)
end
