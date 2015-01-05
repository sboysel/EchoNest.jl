module EchoNest

using Requests
using JSON
using DataStructures

export getartistid, getsongid, getsessioninfo, setAPIkey, artist, 
        genre, song, songsearch, playlist, getdocs

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
                "track" =>["profile", "upload"],
                "playlist" => ["basic"])

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

function getsongid(title::String)
    r = song("profile", title)
    return r["songs"]
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

function getsessioninfo(rate_limit_only::Bool)
    info = Requests.get(buildQuery("artist", "profile", randstring(5))).headers
    if rate_limit_only
        rates = OrderedDict()
        rates["API Key"] = info["X-Api-Key"]
        rates["Limit"] = int(info["X-Ratelimit-Limit"])
        rates["Reamining"] = int(info["X-Ratelimit-Remaining"])
        return rates
    else
        return info
    end
end

function getdocs(api::String, method::String)
    BASE_URL_DOC = "http://developer.echonest.com/docs/v4/"
    if api == "overview"
        error("Overview API documentation includes no specific query methods.")
        return BASE_URL_DOC * "index.html"
    else
        return BASE_URL_DOC * api * ".html#" * method
    end
end

function getdocs(api::String)
    BASE_URL_DOC = "http://developer.echonest.com/docs/v4/"
    if api == "overview"
        error("Overview API documentation includes no specific query methods.")
        return BASE_URL_DOC * "index.html"
    else
        return BASE_URL_DOC * api * ".html"
    end
end

# buildQuery base method
function buildQuery(api::String, method::String, name::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    name = "&name=" * replace(name, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * name * opts 
end

# buildQuery method for passing a method and a name (no options).
function buildQuery(api::String, method::String, name::String)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    name = "&name=" * replace(name, " ", "+")
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * name 
end

# buildQuery method for passing only a method (no options, no name).
function buildQuery(api::String, method::String)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY 
end

# buildQuery method for passing a moethod and options (no name) 
function buildQuery(api::String, method::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * opts 
end

# buildQueryArtist id method
function buildQueryArtist(api::String, method::String, id::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    id = "&id=" * replace(id, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * id * opts 
end

# buildQuerySongs base method

function buildQuerySongsTitle(api::String, method::String, title::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    title = "&title=" * replace(title, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * title * opts 
end

function buildQuerySongsName(api::String, method::String, title::String)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    title = "&title=" * replace(title, " ", "+")
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * title 
end

# buildQuerySongs id method
function buildQuerySongsID(api::String, method::String, id::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    id = "&id=" * replace(id, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * id * opts 
end

# buildQuerySongs id method (no options dictionary)
function buildQuerySongsID(api::String, method::String, id::String)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    id = "&id=" * replace(id, " ", "+")
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * id 
end

# buildQueryPlaylist artist_name method
function buildQueryPlaylist(api::String, method::String, artist_name::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, playlist, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    name = "&name=" * replace(artist_name, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * name * opts 
end

# buildQueryPlaylist song_id method
function buildQueryPlaylist(api::String, method::String, song_id::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, playlist, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * song_id * opts 
end

# buildQueryPlaylist genre method
function buildQueryPlaylist(api::String, method::String, genre::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, playlist, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    genre = "&genre=" * replace(genre, " ", "+")
    opts = ""
    for key in keys(options)
       opts = opts * "&" * string(key) * "=" * string(options[key])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * API_KEY * song_id * opts 
end

### API functions (artist, genre, songs, track, playlist) ###

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

# songsearch base method (query method, name, options dicitonary)
function songsearch(name::String, options::Dict)
    q = buildQuerySongsName("song", "search", name, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

function songsearch(name::String)
    q = buildQuerySongsName("song", "search", name)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# song by song by song id
function song(method::String, id::String, options::Dict)
    q = buildQuerySongsID("song", method, id, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

#=
 =function songname(method::String, name::String)
 =    q = buildQuerySongsName("song", method, name)
 =    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
 =    println(r["status"]["message"])
 =    return r
 =end
 =#

function song(method::String, id::String)
    q = buildQuerySongsID("song", method, id)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# basic playlist by artist name
function playlist(method::String, artist_name::String, options::Dict)
    q = buildQueryPlaylist("playlist", method, artist_name, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# basic playlist by song id 
function playlist(method::String, song_id::String, options::Dict)
    q = buildQueryPlaylist("playlist", method, song_id, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# basic playlist by genre 
function playlist(method::String, genre::String, options::Dict)
    q = buildQueryPlaylist("playlist", method, genre, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

end     # module end
