using DataStructures

proc_output = makedicts(doc, 10)

@testset "document processing" begin

    @test typeof(proc_output[1]) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test length(proc_output[1]) == 277
    @test typeof(proc_output[2]) == Dict{String, Int}
    @test length(proc_output[2]) == 277
    @test typeof(proc_output[3]) == Dict{Int, String}
    @test length(proc_output[3]) == 277

end
