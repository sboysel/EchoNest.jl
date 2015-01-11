## Utility functions

function getartistid(name::String)
    r = artist("profile", name)
    return r["artist"]["id"]
end

function getsongid(title::String, artist::String; first_match = true::Bool)
    r = songsearch(title, artist)
    if first_match
        return r["songs"][1]["id"]
    else
        return r["songs"]
    end
end

# is there a way to do this with only one call?
function audio_summary(title::String, artist::String)
    song_id = getsongid(title, artist; first_match = true)
    r = song("profile", song_id, Dict("bucket" => "audio_summary"))
    return r["songs"][1]
end

function sort_dict(d::Dict)
    o = OrderedDict()
    for i in sort(collect(keys(d)))
        o[i] = d[i]
    end
    return o
end

function setapikey(key::String)
    global ECHO_NEST_API_KEY = key
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

function getdocs(api::String, method::String; browser=true::Bool)
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

