using StatsFuns: logistic
σ = logistic

function _train!(model, η, ::Val{:cbow})
    for context in model.data.ordering #loop over the dataset
        (y,x) = iterate(model.data.xs[context[1]],context[2])[1]
        h = _cbow_h(model, x)

        #calculate the error to update wv
        wv_err = _wv_error_per_output(model, h, y) 

        #loop over the hs weights to update
        _update_all_nodes!(model, h, y, η)

        #update the input vectors
        _cbow_update_wv!(model, x, η, wv_err)
    end
end

function _train!(model, ::Val{:skipgram})
    (x,y) = iterate(model.data.xs[context[1]],context[2])[1]
    @show model
    @show data
    println("skipgram not yet implemented")
end

#cbow model input vector creation
function _cbow_h(model, input)
    h = zeros(size(model.wv.vectors)[1])
    for word in input
        h = h + model.wv.vectors[:,word]
    end
    return h/length(input)
end

function _cbow_update_wv!(model, x, η, wv_err)
    for word in x
        model.wv.vectors[:,word] = model.wv.vectors[:,word] - 1/length(x)*η*wv_err
    end
end


# basic math for updating hidden -> out heirarchical softmax nodes
# h is the wv (:skipgram), or average wv (:cbow)
# v is the weight for an hs node (from nodepaths in model.hs)
# t is the branchpath for the node (from branchpaths in model.hs)
# η is the learning rate
function _hs_update_val(h, v, t, η)
    return η*(σ(v'*h) - t) * h 
end

# uses the function _hs_update_val to update the weight vector for a hs node in place
# eq. 51 from the Rong paper
function _update_hs_node!(model, h, node, t, η)
    model.hs.weights[:,node] = model.hs.weights[:,node] - _hs_update_val(h, model.hs.weights[:,node], t, η) 
end

# function to loop over an entire path through the hs tree for a y value
function _update_all_nodes!(model, h, y, η)
    for (node, branch) in zip(model.hs.nodepaths[y], model.hs.branchpaths[y])
        _update_hs_node!(model, h, node, branch, η)
    end
end

# basic math for calculating the per node error which will be summed (in another function)
# to generate the update value(s) for the wordvectors
# h is the wv (:skipgram), or average wv (:cbow)
# v is the weight for an hs node (from nodepaths in model.hs)
# t is the branchpath for the node (from branchpaths in model.hs)
function _wv_error_per_node(h, v, t)
    return (σ(v'*h) - t) * v
end

# generate the sum of errors across the hs tree for a particular input and output
# h is the wv (:skipgram), or average wv (:cbow)
# y is the output word that should have been predicted (a single word for :cbow, one of several for :skipgram)
# eq. 53 from the Rong paper
function _wv_error_per_output(model, h, y)
    err = zeros(size(model.wv.vectors)[1]) #make a vector of wv size to accumulate error
    for (node, branch) in zip(model.hs.nodepaths[y], model.hs.branchpaths[y])
        err = err + _wv_error_per_node(h, model.hs.weights[:,node], branch)
    end
    return err
end


