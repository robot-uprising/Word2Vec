using Test

# code needed to run tests
include("..\\src\\huffman.jl")
include("utils.jl")

# setup for tests
docpath = "..\\data\\shakespeare.txt"
doc = gen_test_doc(docpath)
crpspath = "..\\data\\shakespeare_all.txt"
crps = gen_test_corpus(crpspath)

# test code
include("proc_doc_tests.jl")
include("huffman_test.jl")
