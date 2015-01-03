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

METHODS_DICT = Dict("artist" => ["biographies", "blogs", "familiarity",
                            "hotttnesss", "images", "list_genres",
                            "list_terms", "news", "profile", "reviews",
                            "search", "extract", "songs", "similar",
                            "suggest", "terms", "top_hottt", "top_terms",
                            "twitter", "urls", "video"],
                "genre" => ["artists", "list", "profile", "search", "similar"],
                "song" => ["search", "profile"],
                "track" =>["profile", "upload"])

# buildQuery base method
function buildQuery(query_type::String, method::String, name::String, options::Dict)
    if query_type in(keys(METHODS_DICT)) == false
        error("query_type must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[query_type]) == false
        error("method must be one of the following: ", METHODS_DICT[query_type])
    end
    name = "&name=" * replace(name, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * query_type * "/" * method * "?api_key=" * API_KEY * name * opts 
end

# buildQuery method for passing a method and a name (no options).
function buildQuery(query_type::String, method::String, name::String)
    if query_type in(keys(METHODS_DICT)) == false
        error("query_type must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[query_type]) == false
        error("method must be one of the following: ", METHODS_DICT[query_type])
    end
    name = "&name=" * replace(name, " ", "+")
    return BASE_URL * query_type * "/" * method * "?api_key=" * API_KEY * name 
end

# buildQuery method for passing only a method (no options, no name).
function buildQuery(query_type::String, method::String)
    if query_type in(keys(METHODS_DICT)) == false
        error("query_type must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[query_type]) == false
        error("method must be one of the following: ", METHODS_DICT[query_type])
    end
    return BASE_URL * query_type * "/" * method * "?api_key=" * API_KEY 
end

# buildQuery method for passing a moethod and options (no name) 
function buildQuery(query_type::String, method::String, options::Dict)
    if query_type in(keys(METHODS_DICT)) == false
        error("query_type must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[query_type]) == false
        error("method must be one of the following: ", METHODS_DICT[query_type])
    end
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * query_type * "/" * method * "?api_key=" * API_KEY * opts 
end


# artist base method (query method, name, options dicitonary)
function artist(method::String, name::String, options::Dict)
    q = buildQuery("artist", method, name, options)
    resp = Requests.get(q)
    if resp.status != 200
        error("Bad response.  Make sure you are using appropriate parameters.
        See http://developer.echonest.com/docs/v4/artist.html")
    end
    return JSON.parse(IOBuffer(resp.data))["response"]
end

# artist method for passing only a query method and name (no options).
function artist(method::String, name::String)
    q = buildQuery("artist", method, name)
    resp = Requests.get(q)
    if resp.status != 200
        error("Bad response.  Make sure you are using appropriate parameters.
        See http://developer.echonest.com/docs/v4/artist.html")
    end
    return JSON.parse(IOBuffer(resp.data))["response"]
end

# artist method for passing only a query method (no options, no name).
function artist(method::String)
    q = buildQuery("artist", method)
    resp = Requests.get(q)
    if resp.status != 200
        error("Bad response.  Make sure you are using appropriate parameters.
        See http://developer.echonest.com/docs/v4/artist.html")
    end
    return JSON.parse(IOBuffer(resp.data))["response"]
end

# artist method for passing a method with options (no name).
function artist(method::String, name::String, options::Dict)
    q = buildQuery("artist", method, options)
    resp = Requests.get(q)
    if resp.status != 200
        error("Bad response.  Make sure you are using appropriate parameters.
        See http://developer.echonest.com/docs/v4/artist.html")
    end
    return JSON.parse(IOBuffer(resp.data))["response"]
end

function getartistid(name::String)
    return artist("profile", name)["response"]["artist"]["id"]
end
