### BUILDQUERY ###

# buildQuery base method
function build_query(api::String, method::String, name::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    name = "&name=" * replace(name, " ", "+")
    opts = ""
    for key in keys(options)
        if isa(options[key], Array)
            for elem in options[key]
                opts = opts * "&" * string(key) * "=" * string(elem)
            end
        else
            opts = opts * "&" * string(key) * "=" * string(options[key])
        end
    end
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * name * opts 
end

# buildQuery method for passing a method and a name (no options).
function build_query(api::String, method::String, name::String)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    name = "&name=" * replace(name, " ", "+")
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * name 
end

# buildQuery method for passing only a method (no options, no name).
function build_query(api::String, method::String)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY 
end

# buildQuery method for passing a moethod and options (no name) 
function build_query(api::String, method::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    opts = ""
    for key in keys(options)
        if isa(options[key], Array)
            for elem in options[key]
                opts = opts * "&" * string(key) * "=" * string(elem)
            end
        else
            opts = opts * "&" * string(key) * "=" * string(options[key])
        end
    end
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * opts 
end

# buildQueryArtist id method
function build_query_artist(api::String, method::String, id::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    id = "&id=" * replace(id, " ", "+")
    opts = ""
    for key in keys(options)
        if isa(options[key], Array)
            for elem in options[key]
                opts = opts * "&" * string(key) * "=" * string(elem)
            end
        else
            opts = opts * "&" * string(key) * "=" * string(options[key])
        end
    end
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * id * opts 
end

# buildQuerySongs
function build_query_songs_title(api::String, method::String, title::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    title = "&title=" * replace(title, " ", "+")
    opts = ""
    for key in keys(options)
        if isa(options[key], Array)
            for elem in options[key]
                opts = opts * "&" * string(key) * "=" * string(elem)
            end
        else
            opts = opts * "&" * string(key) * "=" * string(options[key])
        end
    end
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * title * opts 
end

function build_query_songs_title(api::String, method::String, title::String)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    title = "&title=" * replace(title, " ", "+")
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * title 
end

function build_query_songs_title_artist(api::String, method::String, title::String, artist::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    title = "&title=" * replace(title, " ", "+")
    artist = "&artist=" * replace(artist, " ", "+")
    opts = ""
    for key in keys(options)
        if isa(options[key], Array)
            for elem in options[key]
                opts = opts * "&" * string(key) * "=" * string(elem)
            end
        else
            opts = opts * "&" * string(key) * "=" * string(options[key])
        end
    end
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * title * artist *opts 
end

function build_query_songs_title_artist(api::String, method::String, title::String, artist::String)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    title = "&title=" * replace(title, " ", "+")
    artist = "&artist=" * replace(title, " ", "+")
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * title * artist 
end

# buildQueryID
function build_query_id(api::String, method::String, id::String, options::Dict)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    id = "&id=" * replace(id, " ", "+")
    opts = ""
    for key in keys(options)
        if isa(options[key], Array)
            for elem in options[key]
                opts = opts * "&" * string(key) * "=" * string(elem)
            end
        else
            opts = opts * "&" * string(key) * "=" * string(options[key])
        end
    end
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * id * opts 
end

# buildQueryID method (no options dictionary)
function build_query_id(api::String, method::String, id::String)
    if api in(keys(METHODS_DICT)) == false
        error("api must be artist, genre, song, or track")
    end
    if method in(METHODS_DICT[api]) == false
        error("method must be one of the following: ", METHODS_DICT[api])
    end
    id = "&id=" * replace(id, " ", "+")
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * id 
end

# buildQueryPlaylist artist_name method
function build_query_playlist(api::String, method::String, base::String, input::String, options::Dict)
    if base == "artist"
        input = "&name=" * replace(input, " ", "+") * "&type" * base * "-radio"
    elseif base == "song"
        input = "&song_id=" * replace(input, " ", "+") * "&type" * base * "-radio"
    elseif base == "genre"
        input = "&genre=" * replace(input, " ", "+") * "&type" * base * "-radio"
    else
        error("base_type must be artist, genre, or song")
    end
    opts = ""
    for key in keys(options)
        if isa(options[key], Array)
            for elem in options[key]
                opts = opts * "&" * string(key) * "=" * string(elem)
            end
        else
            opts = opts * "&" * string(key) * "=" * string(options[key])
        end
    end
    return BASE_URL * api * "/" * method * "?api_key=" * ECHO_NEST_API_KEY * input * opts 
end

