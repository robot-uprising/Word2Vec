using DataStructures

@testset "input processing" begin

    sentences = [["hi", "tests", "world"], ["tests", "are", "sure", "fun"]]
    unigrams = Dict("tests" => 2, "hi" => 1, "world" => 1, "are" => 1, "sure" => 1, "fun" => 1)
    true_vocab = ["hi", "tests", "world", "are", "sure", "fun"]
    true_frequencies = Dict(key=>value/2 for (key, value) in unigrams)

    processed = process_input(sentences, 1, 1, :skipgram)

    @test processed.freq_table == true_frequencies
    @test typeof(processed.pq) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    vocab_test1 = [in(word, processed.vocab) for word in true_vocab]
    @test in(false, vocab_test1) ? false : true
    vocab_test2 = [in(word, true_vocab) for word in processed.vocab]
    @test in(false, vocab_test2) ? false : true
    @test typeof(processed.vocab_hash) <: Dict{String, Int}

end
