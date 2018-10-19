using LightGraphs
using MetaGraphs

huff_output = createbinarytree(doc, 10)

@testset "huffman tree" begin

    @test typeof(huff_output[1]) == MetaGraph{Int64,Float64}
    @test length(huff_output[1]) == 305809
    @test typeof(huff_output[2]) == Dict{String, Int}
    @test length(huff_output[2]) == 553
    @test typeof(huff_output[3]) == Dict{Int, String}
    @test length(huff_output[3]) == 553

end
