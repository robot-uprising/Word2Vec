@testset "context data" begin

    sentences = [["hi", "tests", "world"], ["tests", "are", "sure", "fun"]]
    cs = [Context(3, ["hi", "tests", "world"]), Context(3, ["tests", "are", "sure", "fun"])]
    true_skipgram = word2vecdata(:skipgram)
    true_cbow = word2vecdata(:cbow)
    for context in cs
        push!(true_skipgram, context)
        push!(true_cbow, context)
    end

    skipgram_data = (process_input(sentences, 1, 1, :skipgram)).data

    @test length(skipgram_data) == length(true_skipgram)
    for i in 1:length(skipgram_data)
        @test iterate(skipgram_data, i) == iterate(true_skipgram, i)
    end

    cbow_data = (process_input(sentences, 1, 1, :cbow)).data

    @test length(cbow_data) == length(true_cbow)
    for i in 1:length(cbow_data)
        @test iterate(cbow_data, i) == iterate(true_cbow, i)
    end

    # cbow = CBOWData(:cbow, contexts)
    # skipgram = CBOWData(:skipgram, contexts)
    #
    # @test iterate(skipgram) == (("tests", ["hi", "world"]), 2)
    # @test iterate(cbow) == ((["hi", "world"], "tests"), 2)

end
