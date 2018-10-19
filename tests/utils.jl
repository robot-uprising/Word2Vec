using TextAnalysis

flags = [strip_corrupt_utf8,
        strip_case,
        strip_whitespace,
        strip_punctuation,
        strip_numbers,
        strip_html_tags]

function gen_test_doc(path)
    sd = StringDocument(text(FileDocument(path)))
    for flag in flags
        prepare!(sd, flag)
    end
    sd
end
