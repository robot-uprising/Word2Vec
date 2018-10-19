using DataStructures



@testset "document processing" begin

    proc_output = makedicts(docpath, 10)
    @test typeof(proc_output[1]) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test typeof(proc_output[2]) == Dict{String, Int}
    @test typeof(proc_output[3]) == Dict{Int, String}

    proc_output = makedicts(doc, 10)
    @test typeof(proc_output[1]) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test typeof(proc_output[2]) == Dict{String, Int}
    @test typeof(proc_output[3]) == Dict{Int, String}

    proc_output = makedicts(crps, 10)
    @test typeof(proc_output[1]) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test typeof(proc_output[2]) == Dict{String, Int}
    @test typeof(proc_output[3]) == Dict{Int, String}

end
