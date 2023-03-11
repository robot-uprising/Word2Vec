using DataStructures

@testset "Input Processing Tests" begin

    sentences = [["hi", "tests", "world"], ["tests", "are", "sure", "fun"]]
    unigrams = Dict(6 => 2, 5 => 1, 4 => 1, 3 => 1, 2 => 1, 1 => 1)
    true_vocab = ["sure", "fun", "hi", "are", "world", "tests"]
    true_frequencies = Dict(key=>value/7 for (key, value) in unigrams)
    test_vocab_hash = Dict("tests" => 1)

    processed = process_input(sentences, 1, 1)
    processed2 = process_input(sentences, 2, 1)

    @test processed.freq_table == true_frequencies
    @test typeof(processed.pq) == PriorityQueue{String, Int64, Base.Order.ForwardOrdering}
    vocab_test1 = [in(word, processed.vocab) for word in true_vocab]
    @test in(false, vocab_test1) ? false : true
    vocab_test2 = [in(word, true_vocab) for word in processed.vocab]
    @test in(false, vocab_test2) ? false : true
    @test typeof(processed.vocab_hash) <: Dict{String, Int}
    @test test_vocab_hash == processed2.vocab_hash

end
