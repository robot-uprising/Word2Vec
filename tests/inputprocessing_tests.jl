using DataStructures

@testset "input processing" begin

    sentences = [["hi", "tests", "world"], ["tests", "are", "sure", "fun"]]
    true_unigrams = Dict("tests" => 2, "hi" => 1, "world" => 1, "are" => 1, "sure" => 1, "fun" => 1)
    true_contexts = [("hi", "tests", "world"), ("tests", "are", "sure"), ("are", "sure", "fun")]

    pq, vocab_hash, contexts, unigrams = _process_input(sentences, 1, 1)

    @test typeof(pq) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test unigrams == true_unigrams
    test_contexts = []
    for line in contexts
        for context in line
            push!(test_contexts, context)
        end
    end
    @test test_contexts == true_contexts

end
