using DataStructures

@testset "input processing" begin

    sentences = [["hi", "tests", "world"], ["tests", "are", "sure", "fun"]]
    unigrams = Dict("tests" => 2, "hi" => 1, "world" => 1, "are" => 1, "sure" => 1, "fun" => 1)
    true_vocab = ["hi", "tests", "world", "are", "sure", "fun"]
    true_frequencies = Dict(key=>value/2 for (key, value) in unigrams)
    true_contexts = [("hi", "tests", "world"), ("tests", "are", "sure"), ("are", "sure", "fun")]

    freq_table, vocab_hash, vocab, pq, contexts = process_input(sentences, 1, 1)

    @test freq_table == true_frequencies
    @test typeof(pq) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    vocab_test1 = [in(word, vocab) for word in true_vocab]
    @test in(false, vocab_test1) ? false : true
    vocab_test2 = [in(word, true_vocab) for word in vocab]
    @test in(false, vocab_test2) ? false : true
    # @test vocab_hash = Dict
    test_contexts = []
    for line in contexts
        for context in line
            push!(test_contexts, context)
        end
    end
    @test test_contexts == true_contexts

end
