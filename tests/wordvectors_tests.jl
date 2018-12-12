@testset "word vectors" begin
    wn = W2VNetwork(doc, 5, 100)
    wv = wn.wv
    a = cosine_similar_words(wn, "something", 2)
    println(a)

end
