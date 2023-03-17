@testset "Test text document tokenization" begin
    true_sentences =    [["there", "was", "a", "king", "who", "had", "twelve", "beautiful", "daughters"],
                    ["they", "slept", "in", "twelve", "beds", "all", "in", "one", "room", "and", "when", "they", "went", "to", "bed", "the", "doors", "were", "shut", "and", "locked", "up"],
                    ["but", "every", "morning", "their", "shoes", "were", "found", "to", "be", "quite", "worn", "through", "as", "if", "they", "had", "been", "danced", "in", "all", "night"],
                    ["and", "yet", "nobody", "could", "find", "out", "how", "it", "happened", "or", "where", "they", "had", "been"],
                    ["then", "the", "king", "made", "it", "known", "to", "all", "the", "land", "that", "if", "any", "person", "could", "find", "out", "where", "it", "was", "that", "the", "princesses",
                    "danced", "in", "the", "night", "he", "should", "have", "the", "one", "he", "liked", "best", "for", "his", "wife"],
                    ["but", "whoever", "tried", "and", "did", "not", "succeed", "after", "three", "days", "and", "nights", "should", "be", "put", "to", "death"],
                    ["a", "king", "s", "son", "soon", "came"],
                    ["he", "was", "well", "entertained", "and", "in", "the", "evening", "was", "taken", "to", "the", "chamber", "next", "to", "the", "one", "where", "the", "princesses", "lay", "in", "their", "twelve", "beds"],
                    ["there", "he", "was", "to", "sit", "and", "watch", "where", "they", "went", "to", "dance"],
                    ["but", "the", "king", "s", "son", "soon", "fell", "asleep"],
                    ["and", "when", "he", "awoke", "in", "the", "morning", "he", "found", "that", "the", "princesses", "had", "all", "been", "dancing", "for", "the", "soles", "of", "their", "shoes", "were", "full", "of", "holes"],
                    ["the", "same", "thing", "happened", "the", "second", "and", "third", "night", "so", "the", "king", "ordered", "his", "head", "to", "be", "cut", "off"],
                    ["after", "him", "came", "several", "others", "but", "they", "had", "all", "the", "same", "luck", "and", "all", "lost", "their", "lives", "in", "the", "same", "manner"]]

    sentences = tokenize_document("./tests/test_data.txt")

    @test sentences == true_sentences
end
