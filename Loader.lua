local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local API_URL = "https://script.google.com/macros/s/AKfycbwOwX49ODHPB1UVJB6y5JRnLSeB_FHM8mYr_d5Y6MC8Af0eQH5N9wnAHPl6JWhKSKRo/exec"
local PAYLOAD_URL = "https://raw.githubusercontent.com/beiyryeiyr7-crypto/Thai/refs/heads/main/Payload.txt"

local player = Players.LocalPlayer
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

local function checkKey(key)
    local success, response = pcall(function()
        local url = API_URL .. "?key=" .. HttpService:UrlEncode(key) 
                 .. "&hwid=" .. HttpService:UrlEncode(hwid)
                 .. "&username=" .. HttpService:UrlEncode(player.Name)
        return game:HttpGet(url)
    end)
    
    if not success then return false end

    local decodeSuccess, data = pcall(function()
        return HttpService:JSONDecode(response)
    end)
    
    if not decodeSuccess then return false end
    
    return data.success == true
end

-- UI
local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 160)
frame.Position = UDim2.new(0.5, -175, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = sg

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
title.Text = "Key System"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local keybox = Instance.new("TextBox")
keybox.Size = UDim2.new(0.9, 0, 0, 45)
keybox.Position = UDim2.new(0.05, 0, 0.4, 0)
keybox.PlaceholderText = "Enter Key"
keybox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
keybox.TextColor3 = Color3.new(1,1,1)
keybox.TextScaled = true
keybox.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.9, 0, 0, 45)
btn.Position = UDim2.new(0.05, 0, 0.75, 0)
btn.Text = "Submit"
btn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
btn.TextColor3 = Color3.new(1,1,1)
btn.TextScaled = true
btn.Font = Enum.Font.GothamBold
btn.Parent = frame

btn.MouseButton1Click:Connect(function()
    local key = keybox.Text:match("^%s*(.-)%s*$")
    if key and key \~= "" then
        if checkKey(key) then
            local s, payload = pcall(function() return game:HttpGet(PAYLOAD_URL) end)
            if s then
                pcall(function() loadstring(payload)() end)
            end
        end
    end
end)
