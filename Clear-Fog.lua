loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Script-Beta/refs/heads/main/Script-By-HKTD.lua", true))()

local Lighting = game:GetService("Lighting")

local function ClearFog()
    Lighting.FogEnd = 9e9
    Lighting.FogStart = 0
    
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") then
            v.Density = 0
            v.Haze = 0
            v.Glare = 0
        elseif v:IsA("BlurEffect") or v:IsA("SunRaysEffect") then
            v.Enabled = false
        end
    end
    
    Lighting.GlobalShadows = false
    Lighting.Brightness = 2
end

ClearFog()
