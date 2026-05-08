local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local API_URL = "https://script.google.com/macros/s/AKfycbyGX79mHx_XeIXu1uxnmyiREL3ZytKrsv_1MsUorBZfE5lvlmioiX6iGNP61pMTwlJy/exec"
local PAYLOAD_URL = "https://raw.githubusercontent.com/beiyryeiyr7-crypto/Thai/refs/heads/main/Payload.txt"

local player = Players.LocalPlayer

-- แก้ปัญหา Error บรรทัดที่ 6 (GetClientId)
local success_hwid, hwid = pcall(function() 
    return game:GetService("RbxAnalyticsService"):GetClientId() 
end)
if not success_hwid or not hwid then
    hwid = "Mobile-" .. player.UserId
end

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

-- UI Setup
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
    local key = keybox.Text:gsub("%s+", "") -- ลบช่องว่างออกอัตโนมัติ
    if key ~= "" then
        btn.Text = "Checking..."
        if checkKey(key) then
            btn.Text = "Success!"
            task.wait(1)
            sg:Destroy()
            local s, payload = pcall(function() return game:HttpGet(PAYLOAD_URL) end)
            if s then
                loadstring(payload)()
            end
        else
            btn.Text = "Invalid Key!"
            task.wait(1)
            btn.Text = "Submit"
        end
    end
end)
