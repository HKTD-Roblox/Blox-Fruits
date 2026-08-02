-- Load UI
loadstring(game:HttpGet("https://raw.githubusercontent.com/HKTD-Roblox/Script-Beta/refs/heads/main/Script-By-HKTD.lua", true))()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- Blox Fruits PlaceIds
local BloxFruitsPlaces = {
	[2753915549] = true, -- First Sea
	[4442272183] = true, -- Second Sea
	[7449423635] = true  -- Third Sea
}

-- Check if the game is Blox Fruits
if not BloxFruitsPlaces[game.PlaceId] then
	LocalPlayer:Kick("This script only works in Blox Fruits!")
	return
end

local function ClearFog()
	-- Remove Roblox fog
	Lighting.FogStart = 0
	Lighting.FogEnd = 1000000000

	-- Full Bright
	Lighting.Brightness = 3
	Lighting.GlobalShadows = false
	Lighting.ExposureCompensation = 1

	-- Blox Fruits lighting effects
	if Lighting:FindFirstChild("LightingLayers") then
		Lighting.LightingLayers:Destroy()
	end

	if Lighting:FindFirstChild("SeaTerrorCC") then
		Lighting.SeaTerrorCC:Destroy()
	end

	if Lighting:FindFirstChild("FantasySky") then
		Lighting.FantasySky:Destroy()
	end

	-- Atmosphere / post-processing
	for _, v in ipairs(Lighting:GetChildren()) do
		if v:IsA("Atmosphere") then
			v.Density = 0
			v.Haze = 0
			v.Glare = 0

		elseif v:IsA("BlurEffect") then
			v.Enabled = false
			v.Size = 0

		elseif v:IsA("SunRaysEffect") then
			v.Enabled = false
			v.Intensity = 0

		elseif v:IsA("ColorCorrectionEffect") then
			v.Enabled = false

		elseif v:IsA("BloomEffect") then
			v.Enabled = false
			v.Intensity = 0

		elseif v:IsA("DepthOfFieldEffect") then
			v.Enabled = false
		end
	end
end

-- Run Clear Fog once
ClearFog()
