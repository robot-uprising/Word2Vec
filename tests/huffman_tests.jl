# @testset "huffman tree" begin
include("../Huffman/src/Huffman.jl")
using Huffman
#using Inputprocessing


    # ary = Array{Array{Int64,1},1}()
    # for i in keys(vocab_hash)
    #     nodepath, branchpath = rootpath(ht, vocab_hash, i)
    #     push!(ary, branchpath)
    # end
    # @test allunique(ary)

    key = ["this", "is", "the", "most", "WICKED", "AWESOME", "test", "evar!"]
    prior = [128,64,32,16,8,4,2,1]

    pq, vocab_hash = _dicts(Dict(zip(key, prior)), 0)
    ht = HuffmanTree(_binarytree(pq, vocab_hash)...)
    ary1 = Array{Tuple{Array{Int64,1},Array{Int64,1}},1}()
    for i in key
        push!(ary1, rootpath(ht, vocab_hash, i))
    end
    paths = [([15], [0]),
            ([14, 15], [0, 1]),
            ([13, 14, 15], [0, 1, 1]),
            ([12, 13, 14, 15], [0, 1, 1, 1]),
            ([11, 12, 13, 14, 15], [0, 1, 1, 1, 1]),
            ([10, 11, 12, 13, 14, 15], [0, 1, 1, 1, 1, 1]),
            ([9, 10, 11, 12, 13, 14, 15], [0, 1, 1, 1, 1, 1, 1]),
            ([9, 10, 11, 12, 13, 14, 15], [1, 1, 1, 1, 1, 1, 1])]
    @test ary1 == paths

# end
