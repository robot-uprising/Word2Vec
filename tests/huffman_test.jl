using LightGraphs
using MetaGraphs


@testset "huffman tree" begin

    mg, w2id, id2w = createbinarytree(docpath, 10)
    @test typeof(mg) == MetaGraph{Int64,Float64}
    @test typeof(w2id) == Dict{String, Int}
    @test typeof(id2w) == Dict{Int, String}
    nodes = nv(mg)
    @test nodes == 2*length(w2id)-1

    mg, w2id, id2w = createbinarytree(docpath, 10)
    @test typeof(mg) == MetaGraph{Int64,Float64}
    @test typeof(w2id) == Dict{String, Int}
    @test typeof(id2w) == Dict{Int, String}
    nodes = nv(mg)
    @test nodes == 2*length(w2id)-1

    mg, w2id, id2w = createbinarytree(docpath, 10)
    @test typeof(mg) == MetaGraph{Int64,Float64}
    @test typeof(w2id) == Dict{String, Int}
    @test typeof(id2w) == Dict{Int, String}
    nodes = nv(mg)
    @test nodes == 2*length(w2id)-1

end
