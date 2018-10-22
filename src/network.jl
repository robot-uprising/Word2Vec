mutable struct W2VNetwork{S<:AbstractString, T<:Real, H<:Integer}
    wv::WordVectors{S,T,H} #WordVectos struct
    ht::HuffTree{H} #Huffman Tree struct
    ov::AbstractArray{T,2} #Out put vectors
end
