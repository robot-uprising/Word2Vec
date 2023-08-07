@testset "Test HuffmanTree and allpaths function" begin

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

@testset "Generate HuffmanTree using tokenized document" begin
    
    sentences = tokenize_document("./tests/test_data.txt")
    processed = process_input(sentences, 5, 5) #sentences was generated before in the tokenization tests
    ht1 = HuffmanTree(processed.pq, processed.vocab_hash)
    test_nodes1, test_branches1 = allpaths(ht1, processed.vocab_hash, processed.vocab)

    true_nodes1 =   [[3, 6, 8, 9],
                    [3, 6, 8, 9],
                    [2, 6, 8, 9],
                    [7, 9],
                    [1, 5, 8, 9],
                    [4, 7, 9],
                    [4, 7, 9],
                    [2, 6, 8, 9],
                    [5, 8, 9],
                    [1, 5, 8, 9]]

    true_branches1 =    [[1, 0, 0, 0],
                        [0, 0, 0, 0],
                        [0, 1, 0, 0],
                        [0, 1],
                        [1, 1, 1, 0],
                        [0, 1, 1],
                        [1, 1, 1],
                        [1, 1, 0, 0],
                        [0, 1, 0],
                        [0, 1, 1, 0]]
     
    @test test_nodes1 == true_nodes1
    @test test_branches1 == true_branches1
end

sentences = tokenize_document("./tests/test_data.txt")
processed = process_input(sentences, 5, 5) #sentences was generated before in the tokenization tests
ht1 = HuffmanTree(processed.pq, processed.vocab_hash)
test_nodes1, test_branches1 = allpaths(ht1, processed.vocab_hash, processed.vocab)

