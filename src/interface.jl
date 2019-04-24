function word2vec(vector_size, sentences, mincount, window, model)
    vocab_hash, vocab, pq, data = process_input(sentences, mincount, window, model)
    wv = WordVectors(vector_size, vocab, vocab_hash)
    hs = HeirarchicalSoftmax(vector_size, pq, vocab_hash, vocab)
    model = (wv = wv, hs = hs)
    return model, data
end
