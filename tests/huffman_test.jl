@testset "huffman tree" begin

    ht, vocab_hash = createbinarytree(docpath, 10)
    @test typeof(ht) == HuffTree{Int}
    @test typeof(vocab_hash) == Dict{String, Int}
    @test length(ht.nparent) == 2*length(vocab_hash)-1

    ht, vocab_hash = createbinarytree(doc, 10)
    @test typeof(ht) == HuffTree{Int}
    @test typeof(vocab_hash) == Dict{String, Int}
    @test length(ht.nparent) == 2*length(vocab_hash)-1

    ht, vocab_hash = createbinarytree(crps, 10)
    @test typeof(ht) == HuffTree{Int}
    @test typeof(vocab_hash) == Dict{String, Int}
    @test length(ht.nparent) == 2*length(vocab_hash)-1

end
