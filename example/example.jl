using Revise
using Word2Vec

const VECTOR_SIZE = 100
const DATA = "./data/shakespeare_all.txt"
const MINCOUNT = 5
const WINDOW = 5
const MODEL_TYPE = :cbow

model = init_model(VECTOR_SIZE, tokenize_document(DATA), MINCOUNT, WINDOW, MODEL_TYPE)







