import Random: shuffle!

struct Context{I<:Integer, J<:AbstractArray{<:Integer,1}}
    n::I
    xs::J

    function Context(n, xs)
        n > 0 || error("context window must be a positive integer - window size $n provided")
        length(xs) > 1 || error("cannot iterate over an x of 1 or less")
        return new{typeof(n), typeof(xs)}(n, xs)
    end
end

function Base.iterate(c::Context{I}, state = 1) where I<:Integer
    if state < 1 || state > length(c.xs) + 1
        error("Invalid iterator state parameter")
    elseif state == length(c.xs) + 1
        return nothing
    else

        if state ≤ c.n
            state == 1 ? lv = I[] : lv = view(c.xs, 1:state-1)
        else
            lv = view(c.xs, state-c.n:state-1)
        end
        if state ≥ length(c.xs) - c.n + 1
            state == length(c.xs) ? uv = I[] : uv = view(c.xs, state+1:length(c.xs))
        else
            uv = view(c.xs, state+1:state+c.n)
        end
        word = c.xs[state]
        v = vcat(lv, uv)
        return ((word, v), state + 1)
    end
end

function Base.length(c::Context)
    return length(c.xs)
end
