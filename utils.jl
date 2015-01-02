using Requests
using JSON

url =
"http://developer.echonest.com/api/v4/song/profile?api_key=JOCUGCFQZH2MXLEDN&id=SONFQGM13AAD11E6F2&format=json&bucket=audio_summary"
r = get(url)
data = JSON.parse(IOBuffer(r.data))
data["response"]["songs"][1]["audio_summary"]
