using TextAnalysis



function gen_test_doc(path)
    sd = StringDocument(text(FileDocument(path)))
    for flag in flags
        prepare!(sd, flag)
    end
    sd
end

function gen_test_corpus(path)
    s = open(path) do f
        read(f, String)
    end

    sarray = split(s, r"<<|>>")
    txtarray = Array{AbstractDocument, 1}()
    for i in sarray
        if length(i) < 525
            continue
        else
            push!(txtarray, StringDocument(String(i)))
        end
    end

    crps = Corpus(txtarray)

    for flag in flags
        prepare!(crps, flag)
    end
    crps
end
