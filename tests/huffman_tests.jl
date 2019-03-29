@testset "HuffmanTree and allpaths function" begin

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

    test_nodes, test_branches = allpaths(ht, vocab_hash, words)

    true_nodes = [[7], [6, 7], [5, 6, 7], [4, 5, 6, 7], [3, 4, 5, 6, 7],
                  [2, 3, 4, 5, 6, 7], [1, 2, 3, 4, 5, 6, 7],
                  [1, 2, 3, 4, 5, 6, 7]]

    true_branches = [[0], [0, 1], [0, 1, 1], [0, 1, 1, 1], [0, 1, 1, 1, 1],
                     [0, 1, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1, 1],
                     [1, 1, 1, 1, 1, 1, 1]]

   @test test_nodes == true_nodes
   @test test_branches == true_branches
end
