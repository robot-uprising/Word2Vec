using DataStructures



@testset "document processing" begin

    proc_output = makedicts(docpath, 10)
    @test typeof(proc_output1[1]) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test typeof(proc_output1[2]) == Dict{String, Int}
    @test typeof(proc_output1[3]) == Dict{Int, String}

    proc_output = makedicts(doc, 10)
    @test typeof(proc_output1[1]) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test typeof(proc_output1[2]) == Dict{String, Int}
    @test typeof(proc_output1[3]) == Dict{Int, String}

    proc_output = makedicts(crps, 10)
    @test typeof(proc_output1[1]) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test typeof(proc_output1[2]) == Dict{String, Int}
    @test typeof(proc_output1[3]) == Dict{Int, String}

end
