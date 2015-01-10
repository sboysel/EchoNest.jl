### CONF ###

# Keys & secrects will need to be removed from conf.jl and set via utility
# functions for initial release.
ECHO_NEST_API_KEY = "JOCUGCFQZH2MXLEDN" 
CONSUMER_KEY = "b4546780794ccae85068d2fd6c472c73"
SHARED_SECRET = "WqeyUj33Q92QcKU4uklKlA"

global BASE_URL = "http://developer.echonest.com/api/v4/"

global METHODS_DICT = OrderedDict()
METHODS_DICT["artist"] = ["biographies", "blogs", "familiarity", "hotttnesss",
"images", "list_genres", "list_terms", "news", "profile", "reviews", "search",
"extract", "songs", "similar", "suggest", "terms", "top_hottt", "top_terms",
"twitter","urls", "video"]
METHODS_DICT["genre"] = ["artists", "list", "profile", "search", "similar"]
METHODS_DICT["song"] = ["search", "profile"]
METHODS_DICT["track"] = ["profile", "upload"]
METHODS_DICT["playlist"] = "basic"
