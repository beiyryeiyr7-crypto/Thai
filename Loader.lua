local API_URL = "https://script.google.com/macros/s/AKfycbz-EnqusNt0U4wYPj5H57n09DxQDtZUS5RU21kyiHKvQa919QzJvNNvSvgBrk8FWNwr/exec"

local HttpService = game:GetService("HttpService")
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local function checkKey(key)
    local url = API_URL .. "?auth=" .. key .. "&hwid=" .. HWID
    -- Using game:HttpGet for better stability on Delta/Mobile executors
    local success, response = pcall(function()
        return game:HttpGet(https://raw.githubusercontent.com/beiyryeiyr7-crypto/Thai/refs/heads/main/Payload.txt)
    end)
    return success, response
end

-- Example usage for your LOGIN button
local inputKey = "ENTER_KEY_HERE"
local success, response = checkKey(inputKey)

if success then
    if response ~= "FAILED" and response ~= "HWID_MISMATCH" then
        print("Authentication Success!")
        -- Executing the obfuscated code received from the server
        local run, err = loadstring(response)
        if run then
            run()
        else
            warn("Execution Error: " .. tostring(err))
        end
    elseif response == "HWID_MISMATCH" then
        print("Error: Key is locked to another device.")
    else
        print("Error: Invalid Key.")
    end
else
    print("Connection Failed! Check your internet or Script Deployment settings.")
end
