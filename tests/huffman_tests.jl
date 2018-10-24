@testset "huffman tree" begin

    ht, vocab_hash = _createbinarytree(docpath, 10)
    @test typeof(ht) == HuffTree{Int}
    @test typeof(vocab_hash) == Dict{String, Int}
    @test length(ht.nodeparent) == 2*length(vocab_hash)-1

    ht, vocab_hash = _createbinarytree(doc, 10)
    @test typeof(ht) == HuffTree{Int}
    @test typeof(vocab_hash) == Dict{String, Int}
    @test length(ht.nodeparent) == 2*length(vocab_hash)-1

    ht, vocab_hash = _createbinarytree(crps, 10)
    @test typeof(ht) == HuffTree{Int}
    @test typeof(vocab_hash) == Dict{String, Int}
    @test length(ht.nodeparent) == 2*length(vocab_hash)-1

    ary = Array{Array{Int64,1},1}()
    for i in keys(vocab_hash)
        nodepath, branchpath = _rootpath(ht, vocab_hash, i)
        push!(ary, branchpath)
    end

    @test allunique(ary)

end
