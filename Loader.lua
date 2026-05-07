local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local API = "https://script.google.com/macros/s/AKfycbzo1UQy_Gw69M-EzrJrXgKSdocvEqdZtjyOt6IqAHHG5e0_LbvZ3qQ16eOvt6_Ue5_l/exec"
local _KEY = getgenv().key or ""
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local function Auth()
    local url = API.."?key="..HttpService:UrlEncode(_KEY).."&hwid="..HttpService:UrlEncode(HWID)
    local success, res = pcall(function() return game:HttpGet(url) end)
    
    if success then
        if res == "SUCCESS" then
            local p_url = "https://raw.githubusercontent.com/beiyryeiyr7-crypto/Thai/refs/heads/main/Payload.txt"
            local s, data = pcall(function() return game:HttpGet(p_url) end)
            if s and data then
                local func, err = loadstring(HttpService:Base64Decode(data))
                if func then func() else warn("LoadError: "..tostring(err)) end
            else
                LocalPlayer:Kick("Fetch Error")
            end
        else
            LocalPlayer:Kick("Auth Failed: "..tostring(res))
        end
    else
        LocalPlayer:Kick("Server Offline")
    end
end
Auth()
