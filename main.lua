-- [[ 🛡️ BEER HUB : MAIN SCRIPT (GITHUB) ]] --
local API_URL = "https://script.google.com/macros/s/AKfycbyXTPdSncvtjbL3ofdl0-5Lk1DnriDnyR82wjH8zCyXWpbqAwCyTZDo7lobKctaCYFg/exec"
local L_Player = game:GetService("Players").LocalPlayer

local function Verify(key)
    local ok, res = pcall(function() 
        return game:HttpGet(API_URL .. "?auth=" .. key .. "&hwid=" .. game:GetService("RbxAnalyticsService"):GetClientId()) 
    end)
    return (ok and res:find("SUCCESS"))
end

if Verify(_G.BeerHubKey) then
    -- [[ วางโค้ดตัวเต็ม Beer Hub ที่มึงเคยส่งให้กูตรงนี้ ]] --
    print("🍺 Beer Hub : Authorized!")
    -- (ก๊อปโค้ด UI และระบบ Fix ที่มึงมีมาวางต่อท้ายตรงนี้ได้เลย)
else
    L_Player:Kick("❌ Key ผิดหรือ HWID ไม่ตรง!")
end
