# using TextAnalysis
#
# path = "..\\data\\shakespear.txt"
#
# flags = [strip_corrupt_utf8,
#         strip_case,
#         strip_whitespace,
#         strip_punctuation,
#         strip_numbers,
#         strip_html_tags]
#
# function gendoc(path)
#     sd = StringDocument(text(FileDocument(path)))
#     for flag in flags
#         prepare!(sd, flag)
#     end
# end
using Test

include("..\\src\\proc_doc.jl")
include(".\\utils\\proc_doc_utils.jl")

datapath = ".\\data\\shakespear.txt"
doc = gen_test_doc(datapath)

test_output = makedicts(doc, 10)

@testset "document processing" begin

    @test typeof(test_output[1]) == PriorityQueue{String,Int64,Base.Order.ForwardOrdering}
    @test length(test_output[1]) == 277
    @test typeof(test_output[2]) == Dict{String, Int64}
    @test typeof(test_output[3]) == Dict{String, Int64}
    @test typeof(test_output[4]) == Dict{String, Int64}

end
