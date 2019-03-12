using DataStructures

@testset "input processing" begin

    sentences = [["hi", "tests"], ["tests", "are", "fun"]]
    true_unigrams = Dict("tests" => 2, "hi" => 1, "are" => 1, "fun" => 1)

    pq, vocab_hash, contexts, unigrams = _process_input(sentences, 1, 2)

    @test typeof(pq) == PriorityQueue
    @test unigrams == true_unigrams

end
