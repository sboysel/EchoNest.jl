## SONG ##

# songsearch base method
function songsearch(title::String, artist::String, options::Dict)
    q = build_query_songs_title_artist("song", "search", title, artist, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# songsearch without options dictionary 
function songsearch(title::String, artist::String)
    q = build_query_songs_title_artist("song", "search", title, artist)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# songsearch with only a song title (no options)
function songsearch(title::String)
    q = build_query_songs_title("song", "search", title)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# songsearch with only a song title
function songsearch(title::String, options::Dict)
    q = build_query_songs_title("song", "search", title, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# song by song id
function song(method::String, id::String, options::Dict)
    q = build_query_id("song", method, id, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# song by song id (no options dicitonary)
function song(method::String, id::String)
    q = build_query_id("song", method, id)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

