@testset "huffman tree and path functions" begin

    using DataStructures

    vocab_hash = Dict("this" => 1,
                "is" => 2,
                "the" => 3,
                "most" => 4,
                "WICKED" => 5,
                "AWESOME" =>6,
                "test" => 7,
                "evar!" => 8)

    words = ["this", "is", "the", "most", "WICKED", "AWESOME", "test", "evar!"]

    freqs = [128,64,32,16,8,4,2,1]

    pq = PriorityQueue(Dict(zip(words, freqs)))
    ht = HuffmanTree(pq, vocab_hash)

    ary = Array{Tuple{Array{Int64,1},Array{Int64,1}},1}()
    for word in words
        push!(ary, normalizedpath(ht, vocab_hash, word))
    end

    ary1 = Array{Tuple{Array{Int64,1},Array{Int64,1}},1}()
    for word in words
        push!(ary1, rootpath(ht, vocab_hash, word))
    end

    rootpaths = [([15], [0]),
            ([14, 15], [0, 1]),
            ([13, 14, 15], [0, 1, 1]),
            ([12, 13, 14, 15], [0, 1, 1, 1]),
            ([11, 12, 13, 14, 15], [0, 1, 1, 1, 1]),
            ([10, 11, 12, 13, 14, 15], [0, 1, 1, 1, 1, 1]),
            ([9, 10, 11, 12, 13, 14, 15], [0, 1, 1, 1, 1, 1, 1]),
            ([9, 10, 11, 12, 13, 14, 15], [1, 1, 1, 1, 1, 1, 1])]

   @test ary1 == rootpaths

   normpaths = Array{Tuple{Array{Int64,1},Array{Int64,1}},1}()
   for i in 1:length(rootpaths)
       a, b = rootpaths[i]
       push!(normpaths, (a .- 8, b))
   end

   @test ary == normpaths
end
