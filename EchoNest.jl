module EchoNest

using Requests
using JSON
using DataStructures

export audio_summary, getartistid, getsongid, getsessioninfo, setAPIkey, artist, 
        genre, song, songsearch, playlist, track, getdocs

include("conf.jl")
include("utils.jl")
include("build_query.jl")
include("artist.jl")
include("genre.jl")
include("song.jl")
include("track.jl")
include("playlist.jl")

end 
