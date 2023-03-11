using Word2Vec

sentences = tokenize_document("./data/shakespeare_all.txt")

model, data = word2vec(300, sentences, 3, 3, :skipgram)
