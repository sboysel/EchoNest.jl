## PLAYLIST ##

# basic playlist
function playlist(base::String, input::String, options::Dict)
    q = build_query_playlist("playlist", "basic", base , input, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

function playlist(base::String, input::String)
    q = build_query_playlist("playlist", "basic", base , input)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

