include("utils.jl")

ARTIST_BUCKETS = ["biographies",
"blogs", "discovery", "discovery_rank", "doc_counts", "familiarity",
"familiarity_rank", "genre", "hotttnesss", "hotttnesss_rank", "images",
"artist_location", "news", "reviews", "songs", "terms", "urls", "video",
"years_active", "id:Rosetta-space"]

ARTIST_LICENSES = ["echo-source", "all-rights-reserved", "cc-by-sa",
"cc-by-nc", "cc-by-nc-nd", "cc-by-nc-sa", "cc-by-nd", "cc-by", "public-domain",
"unknown"]

# Pick a random parameter for testing:
# ARTIST_LICENSES[rand(1:end)]

TEST_ARTIST = "circa survive"
TEST_GENRE = "polka"

test1 = artist("biographies", TEST_ARTIST)
test2 = artist("blogs", TEST_ARTIST)
test3 = artist("familiarity", TEST_ARTIST)
test4 = artist("hotttnesss", TEST_ARTIST, Dict("type" => ["overall", "social", "reviews", "mainstream"][rand(1:end)]))
### test5 = artist("list_terms", TEST_ARTIST, Dict("type" => ["style", "mood"][rand(1:end)]))
test6 = artist("news", TEST_ARTIST, Dict("high_relevance" => [true, false][rand(1:end)]))
test7 = artist("profile", TEST_ARTIST, Dict("bucket" => ARTIST_BUCKETS[2]))
test8 = artist("reviews", TEST_ARTIST)
### test9 = artist("search", TEST_ARTIST)
### test10 = artist("extract", TEST_ARTIST)
test11 = artist("songs", TEST_ARTIST)
test12 = artist("similar", TEST_ARTIST, Dict("bucket" => ARTIST_BUCKETS[2],
"max_familiarity" => 1., "min_hotttnesss" => 0.5)) # see http://developer.echonest.com/docs/v4/artist.html#hotttnesss for more options
test13 = artist("suggest", TEST_ARTIST)
test14 = artist("terms", TEST_ARTIST, Dict("sort" => ["weight", "frequency"][rand(1:end)]))
test15 = artist("top_hottt", Dict("buckets" => ARTIST_BUCKETS[3]))
test16 = artist("top_terms")
test17 = artist("twitter", TEST_ARTIST)
test18 = artist("urls", TEST_ARTIST)
test19 = artist("video", TEST_ARTIST)

test20 = genre("artists", TEST_GENRE)
test21 = genre("list", Dict("bucket" => "urls"))
test22 = genre("profile", Dict("bucket" => "description"))
test23 = genre("search", TEST_GENRE, Dict("bucket" => "description", "results" => "50"))
test24 = genre("similar", TEST_GENRE, Dict("bucket" => "urls", "results" => "10"))
