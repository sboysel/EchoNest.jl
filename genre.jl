## GENRE ##

# genre base method (query method, name, options dicitonary)
function genre(method::String, name::String, options::Dict)
    q = build_query("genre", method, name, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# genre method for passing without options (query method, name)
function genre(method::String, name::String)
    q = build_query("genre", method, name)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# genre method for passing without a name (query method, options)
function genre(method::String, options::Dict)
    q = build_query("genre", method, options)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

# genre method for passing only a method (i.e. genre("list"))
function genre(method::String)
    q = build_query("genre", method)
    r = JSON.parse(IOBuffer(Requests.get(q).data))["response"]
    println(r["status"]["message"])
    return r
end

