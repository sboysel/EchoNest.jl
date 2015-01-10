## TRACK ##

# base track method
function track(id::String, options::Dict; method = "profile"::String)
    q = build_query_id("song", method, id, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

