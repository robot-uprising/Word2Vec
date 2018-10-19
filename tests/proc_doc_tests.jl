using DataStructures

proc_output = makedicts(doc, 10)

@testset "document processing" begin

    @test typeof(proc_output[1]) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test length(proc_output[1]) == 277
    @test typeof(proc_output[2]) == Array{String, 1}
    @test length(proc_output[2]) == 277
    @test typeof(proc_output[3]) == Dict{String, Int}
    @test length(proc_output[3]) == 277
    @test typeof(proc_output[4]) == Dict{Int, String}
    @test length(proc_output[4]) == 277

end
