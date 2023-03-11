using Revise
using Word2Vec

sentences = tokenize_document("./data/shakespeare_all.txt")

model = init_model(100, sentences, 2, 5, :cbow)





