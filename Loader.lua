local HttpService = game:GetService("HttpService")

local KEY = getgenv().key or ""

local HWID =
game:GetService("RbxAnalyticsService"):GetClientId()

local API =
"ใส่ลิงก์_APPS_SCRIPT_/exec"

local ok, response = pcall(function()

    return game:HttpGet(
        API ..
        "?key=" .. HttpService:UrlEncode(KEY) ..
        "&hwid=" .. HttpService:UrlEncode(HWID)
    )

end)

if not ok then
    error("SERVER OFFLINE")
end

if response ~= "SUCCESS" then
    error(response)
end

local stage2 =
game:HttpGet(
"https://raw.githubusercontent.com/USERNAME/REPO/main/Stage2.lua"
)

loadstring(stage2)()
