using Word2Vec

struct Model
    wv::WordVectors
    hs::HeirarchicalSoftmax
    data::TextData
    type::Symbol
end

function word2vec()
    println("wow, nothing...")
end

function init_model(vector_size::Int, sentences, mincount::Int=2, window::Int=5, model_type::Symbol=:cbow)
    _, vocab_hash, vocab, pq, data = process_input(sentences, mincount, window)
    wv = init_vectors(vector_size, vocab, vocab_hash)
    hs = init_softmax(pq, vocab_hash, vocab)
    model = Model(wv, hs, data, model_type)
    return model
end

function train_model!(model::Model, shuffle::Bool, epochs::Int, other_stuff)
    println("Model is unchanged, training not yet implemented")
end