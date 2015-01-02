using Requests
using JSON

API_KEY = "JOCUGCFQZH2MXLEDN" 
CONSUMER_KEY = "b4546780794ccae85068d2fd6c472c73"
SHARED_SECRET = "WqeyUj33Q92QcKU4uklKlA"

BASE_URL = "http://developer.echonest.com/api/v4/"

#artist = split(readall("artistMethods"), "\n")
#song = split(readall("songMethods"), "\n")
#genre = split(readall("genreMethods"), "\n")
#track = split(readall("trackMethods"), "\n")

methods = Dict("artist" => ["biographies", "blogs", "familiarity",
                            "hotttnesss", "images", "list_genres",
                            "list_terms", "news", "profile", "reviews",
                            "search", "extract", "songs", "similar",
                            "suggest", "terms", "top_hottt", "top_terms",
                            "twitter", "urls", "video"],
                "genre" => ["artists", "list", "profile", "search", "similar"],
                "song" => ["search", "profile"],
                "track" =>["profile", "upload"])

function buildQuery(query_type::String, method::String, name::String, options::Dict)
    if query_type in(keys(methods)) == false
        error("query_type must be artist, genre, song, or track")
    end
    if method in(methods[query_type]) == false
        error("method must be one of the following: ", methods[query_type])
    end
    name = "&name=" * replace(name, " ", "%")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * query_type * "/" * method * "?api_key=" * API_KEY * name * opts 
end

function artist(method::String, name::String, options::Dict)
    q = buildQuery("artist", method, name, options)
    response = Requests.get(q)
    if response.status != 200
        error("Bad response.  Make sure you are using appropriate parameters.
        See http://developer.echonest.com/docs/v4/artist.html")
    end
    return JSON.parse(IOBuffer(Requests.get(q).data))
end
