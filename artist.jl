## ARTIST ##

# artist base method (query method, name, options dicitonary)
function artist(method::String, name::String, options::Dict)
    q = build_query("artist", method, name, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# artist method for passing only a query method and name (no options).
function artist(method::String, name::String)
    q = build_query("artist", method, name)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r 
end

# artist method for passing only a query method (no options, no name).
function artist(method::String)
    q = build_query("artist", method)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r 
end

# artist method for passing a method with options (no name).
function artist(method::String, options::Dict)
    q = build_query("artist", method, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r 
end

# artist id base method (query method, id, options dicitonary)
function artist(method::String, id::String, options::Dict)
    q = build_query("artist", method, id, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# artist id method for passing only a query method and name (no options).
function artist(method::String, id::String)
    q = build_query("artist", method, id)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r 
end

