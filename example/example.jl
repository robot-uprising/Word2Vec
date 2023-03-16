using Revise
using Word2Vec

const VECTOR_SIZE = 100
const DATA = "./data/big.txt"
const MINCOUNT = 5
const WINDOW = 5
const MODEL_TYPE = :cbow

model = init_model(tokenize_document(DATA), VECTOR_SIZE, WINDOW, MINCOUNT, MODEL_TYPE)

# toy examples
# wv = init_vectors(5, ["hi", "hi", "hi", "hi", "hi", "hi", "hi", "hi", "hi", "hi"], Dict("hi" => 1))
# hs = Word2Vec.HeirarchicalSoftmax(randn(5, 10), [[1]], [[1]])
# context = Context(2, [1, 2, 3, 4, 5])
# data = W2VData([(1,1)], [context], Dict(1 => 0.1))
# model = Word2Vec.Model(wv, hs, data, :cbow)

Word2Vec._update_hs_node!(model, 1, 1, 1, 0.025)

a = Word2Vec._wv_error_per_node(model.wv.vectors[:,1], model.hs.weights[:,1], 1)

function gaga(model)
    out = []
    for a in 1:length(model.hs.nodepaths)
        push!(out, length(model.hs.nodepaths[a]))
    end
    return out   
end

gagout = gaga(model)

using Plots

histogram(gagout)

poo = Real[]
for word in model.wv.vocab
    push!(poo, model.data.freq_table[model.wv.vocab_hash[word]])
end

function testing(poo, gagout)
    out = []
    for (freq, numnodes) in zip(poo, gagout)
        push!(out, floor(Int, freq*100000*numnodes))
    end
    return out
end
lala = testing(poo, gagout)

histogram(gagout, weights=poo)

findmin(gagout)
model.data.freq_table[12357]