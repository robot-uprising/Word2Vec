using LightGraphs
using MetaGraphs


@testset "huffman tree" begin

    huff_output = createbinarytree(docpath, 10)
    @test typeof(huff_output[1]) == MetaGraph{Int64,Float64}
    @test typeof(huff_output[2]) == Dict{String, Int}
    @test typeof(huff_output[3]) == Dict{Int, String}

    huff_output = createbinarytree(doc, 10)
    @test typeof(huff_output[1]) == MetaGraph{Int64,Float64}
    @test typeof(huff_output[2]) == Dict{String, Int}
    @test typeof(huff_output[3]) == Dict{Int, String}

    huff_output = createbinarytree(crps, 10)
    @test typeof(huff_output[1]) == MetaGraph{Int64,Float64}
    @test typeof(huff_output[2]) == Dict{String, Int}
    @test typeof(huff_output[3]) == Dict{Int, String}

end
