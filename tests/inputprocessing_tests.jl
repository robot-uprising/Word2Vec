using DataStructures

@testset "document processing" begin

    pq, vocab_hash = _makedicts(docpath, 10)
    @test typeof(pq) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test typeof(vocab_hash) == Dict{String, Int}

    pq, vocab_hash = _makedicts(doc, 10)
    @test typeof(pq) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test typeof(vocab_hash) == Dict{String, Int}

    pq, vocab_hash = _makedicts(crps, 10)
    @test typeof(pq) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test typeof(vocab_hash) == Dict{String, Int}

end
