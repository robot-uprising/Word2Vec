import Random: shuffle!

struct Context
    n::Int
    xs::Array

    function Context(n, xs)
        n > 0 || error("context window must be a positive integer - window size $n provided")
        n ≤ length(xs) || error("context window must be less than context size")
        return new(n, xs)
    end
end

function Base.iterate(c::Context, state = 1)
    offset = state + c.n -1
    if state < 1 || offset > length(c.xs) + 1
        error("Invalid iterator state parameter")
    elseif offset == length(c.xs) + 1
        return nothing
    else
        v = view(c.xs, state:offset)
        return (v, state + 1)
    end
end

function Base.length(c::Context)
    return length(c.xs) + 1 - c.n
end


# struct ContextData
#     ordering::Array{Tuple}
#     xs::Array{Context}
# end
#
# ContextData() = ContextData([],[])
#
# function Base.push!(cd::ContextData, c::Context)
#     push!(cd.xs, c)
#     position = length(cd.xs)
#     num_contexts = length(c.xs) + 1 - c.n
#     for i in 1:num_contexts
#         push!(cd.ordering, (position, i))
#     end
# end
#
# function shuffle!(cd::ContextData)
#     shuffle!(cd.ordering)
#     return nothing
# end
#
# function Base.length(cd::ContextData)
#     return length(cd.ordering)
# end
#
# function Base.iterate(cd::ContextData, state = 1)
#     if state < 1 || state > length(cd) + 1
#         error("Invalid iterator state parameter")
#     elseif state == length(cd.ordering) + 1
#         return nothing
#     else
#         (contextid, context_state) = cd.ordering[state]
#         (context, _) = iterate(cd.xs[contextid], context_state)
#         return (context, state + 1)
#     end
# end
