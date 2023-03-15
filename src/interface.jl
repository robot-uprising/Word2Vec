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

function init_model(sentences, vector_size::Int, window::Int=5, mincount::Int=2, model_type::Symbol=:cbow)
    _, vocab_hash, vocab, pq, data = process_input(sentences, mincount, window)
    wv = init_vectors(vector_size, vocab, vocab_hash)
    hs = init_softmax(vector_size, pq, vocab_hash, vocab)
    model = Model(wv, hs, data, model_type)
    return model
end

function train_model!(vector_size::Int, data::String, epochs::Int, other_stuff)
    println("Model is unchanged, training not yet implemented")
end

"""
Parameters for training:
    train <file>
        Use text data from <file> to train the model
    output <file>
        Use <file> to save the resulting word vectors / word clusters
    size <Int>
        Set size of word vectors; default is 100
    window <Int>
        Set max skip length between words; default is 5
    sample <AbstractFloat>
        Set threshold for occurrence of words. Those that appear with
        higher frequency in the training data will be randomly
        down-sampled; default is 1e-5.
    hs <Int>
        Use Hierarchical Softmax; default is 1 (0 = not used)
    negative <Int>
        Number of negative examples; default is 0, common values are 
        5 - 10 (0 = not used)
    threads <Int>
        Use <Int> threads (default 12)
    iter <Int>
        Run more training iterations (default 5)
    min_count <Int>
        This will discard words that appear less than <Int> times; default
        is 5
    alpha <AbstractFloat>
        Set the starting learning rate; default is 0.025
    debug <Int>
        Set the debug mode (default = 2 = more info during training)
    binary <Int>
        Save the resulting vectors in binary moded; default is 0 (off)
    cbow <Int>
        Use the continuous back of words model; default is 1 (skip-gram
        model)
    save_vocab <file>
        The vocabulary will be saved to <file>
    read_vocab <file>
        The vocabulary will be read from <file>, not constructed from the
        training data
    verbose <Bool>
        Print output from training 
"""