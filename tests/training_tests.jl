using Word2Vec
import Random
Random.seed!(1234)

const VECTOR_SIZE = 10
const DATA = "./tests/test_data.txt"
const MINCOUNT = 5
const WINDOW = 5
const MODEL_TYPE = :cbow
const MODEL_TYPE_2 = :skipgram

cbow_model = init_model(tokenize_document(DATA), VECTOR_SIZE, WINDOW, MINCOUNT, MODEL_TYPE)
skipgram_model = init_model(tokenize_document(DATA), VECTOR_SIZE, WINDOW, MINCOUNT, MODEL_TYPE_2)

@testset "Summing error for HeirarchicalSoftmax" begin

    input_words = [1, 2, 3, 4, 5]
    h = Word2Vec._cbow_h(cbow_model, input_words)
    y = 10

    err = Word2Vec._wv_error_per_output(cbow_model, h, y)
    
    true_err = [
        1.7812595751765619,
        -0.041083690100777115,
        -0.8519992413343868,
         0.5434990673659555,
         0.7982698216508777,
         0.6194132211648374,
         0.5349863359710199,
         1.1027327904877149,
        -1.553019399302498,
        -0.6076533211231815
    ]

    @test err == true_err
end


    