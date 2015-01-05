module EchoNest

using Requests
using JSON
using DataStructures

export getartistid, getsessioninfo, setAPIkey, artist, 
        genre, song

### BEGIN CONF ###
# Eventually move conf info to conf.jl:
# include("conf.jl")

API_KEY = "JOCUGCFQZH2MXLEDN" 
CONSUMER_KEY = "b4546780794ccae85068d2fd6c472c73"
SHARED_SECRET = "WqeyUj33Q92QcKU4uklKlA"

BASE_URL = "http://developer.echonest.com/api/v4/"

METHODS_DICT = Dict("artist" => ["biographies", "blogs", "familiarity",
                            "hotttnesss", "images", "list_genres",
                            "list_terms", "news", "profile", "reviews",
                            "search", "extract", "songs", "similar",
                            "suggest", "terms", "top_hottt", "top_terms",
                            "twitter", "urls", "video"],
                "genre" => ["artists", "list", "profile", "search", "similar"],
                "song" => ["search", "profile"],
                "track" =>["profile", "upload"])

RESPONSE_CODES = Dict(-1 => "Unknown Error",
                        0 => "Success1Missing",
                        1 => "Invalid API Key",
                        2 => "This API key is not allowed to call this method",
                        3 => "Rate Limit Exceeded",
                        4 => "Missing Parameter",
                        5 => "Invalid Parameter")

### END CONF ###

function getartistid(name::String)
    r = artist("profile", name)
    return r["artist"]["id"]
end

function sortDict(d::Dict)
    o = OrderedDict
    for i in sort(collect(keys(d)))
        o[i] = d[i]
    end
    return o
end

function setAPIkey(key::String)
    #global API_KEY = key
    exp = "API_KEY = " * key
    if isfile("conf.jl")
        include("conf.jl")
    else
        f = open("conf.jl", "w")
        write(f, exp)
        close(f)
        include("conf.jl")
    end
end

function getsessioninfo()
    return sortDict(Requests.get(buildQuery("artist", "songs", "")).headers)
end

function getdocs(api::String, method::String)
    BASE_URL_DOC = "http://developer.echonest.com/docs/v4/"
    if api = "overview"
        error("Overview API documentation includes no specific query methods.")
        return BASE_URL_DOC * "index.html"
    else
        return BASE_URL_DOC * api * ".html#" * method
    end
end

function getdocs(api::String)
    BASE_URL_DOC = "http://developer.echonest.com/docs/v4/"
    if api = "overview"
        error("Overview API documentation includes no specific query methods.")
        return BASE_URL_DOC * "index.html"
    else
        return BASE_URL_DOC * api * ".html"
    end
end

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

# buildQueryArtist id method
function buildQueryArtist(query_type::String, method::String, id::String, options::Dict)
    if query_type in(keys(METHODS_DICT)) == false
        error("query_type must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[query_type]) == false
        error("method must be one of the following: ", METHODS_DICT[query_type])
    end
    id = "&id=" * replace(id, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * query_type * "/" * method * "?api_key=" * API_KEY * id * opts 
end

# buildQuerySongs base method
function buildQuerySongs(query_type::String, method::String, title::String, options::Dict)
    if query_type in(keys(METHODS_DICT)) == false
        error("query_type must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[query_type]) == false
        error("method must be one of the following: ", METHODS_DICT[query_type])
    end
    title = "&title=" * replace(title, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * query_type * "/" * method * "?api_key=" * API_KEY * title * opts 
end

# buildQuerySongs id method
function buildQuerySongs(query_type::String, method::String, id::String, options::Dict)
    if query_type in(keys(METHODS_DICT)) == false
        error("query_type must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[query_type]) == false
        error("method must be one of the following: ", METHODS_DICT[query_type])
    end
    id = "&id=" * replace(id, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * query_type * "/" * method * "?api_key=" * API_KEY * id * opts 
end

# buildQuerySongs id method (no options dictionary)
function buildQuerySongs(query_type::String, method::String, id::String)
    if query_type in(keys(METHODS_DICT)) == false
        error("query_type must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[query_type]) == false
        error("method must be one of the following: ", METHODS_DICT[query_type])
    end
    id = "&id=" * replace(id, " ", "+")
    return BASE_URL * query_type * "/" * method * "?api_key=" * API_KEY * id 
end



# artist base method (query method, name, options dicitonary)
function artist(method::String, name::String, options::Dict)
    q = buildQuery("artist", method, name, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# artist method for passing only a query method and name (no options).
function artist(method::String, name::String)
    q = buildQuery("artist", method, name)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r 
end

# artist method for passing only a query method (no options, no name).
function artist(method::String)
    q = buildQuery("artist", method)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r 
end

# artist method for passing a method with options (no name).
function artist(method::String, options::Dict)
    q = buildQuery("artist", method, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r 
end

# artist id base method (query method, id, options dicitonary)
function artist(method::String, id::String, options::Dict)
    q = buildQuery("artist", method, id, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# artist id method for passing only a query method and name (no options).
function artist(method::String, id::String)
    q = buildQuery("artist", method, id)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r 
end

# genre base method (query method, name, options dicitonary)
function genre(method::String, name::String, options::Dict)
    q = buildQuery("genre", method, name, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# genre method for passing without options (query method, name)
function genre(method::String, name::String)
    q = buildQuery("genre", method, name)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# genre method for passing without a name (query method, options)
function genre(method::String, options::Dict)
    q = buildQuery("genre", method, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# song base method (query method, name, options dicitonary)
function song(method::String, title::String, options::Dict)
    q = buildQuerySongs("song", method, title, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

function song(method::String, id::String, options::Dict)
    q = buildQuerySongs("song", method, id, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

function song(method::String, id::String)
    q = buildQuerySongs("song", method, id)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end


end     # module end
