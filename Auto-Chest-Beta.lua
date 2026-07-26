-- Sourcre By HKTD - Zero

if not game:IsLoaded() then
    game.Loaded:Wait()
end
StarterGui:SetCore("SendNotification", {
    Title = "Auto Chest Beta",
    Text = "Script By Zero",
    Duration = 5
})
_G.SmoothConfig = {Enabled = false, Speed = 0.1, LowGraphic = true, AntiAfk = true, AntiKick = true}
local a = game.Players.LocalPlayer
local b = game:GetService("CoreGui")
if _G.SmoothConfig.AntiKick then
    local c = getrawmetatable(game)
    setreadonly(c, false)
    local d = c.__namecall
    c.__namecall =
        newcclosure(
        function(self, ...)
            if getnamecallmethod() == "Kick" then
                return nil
            end
            return d(self, ...)
        end)
    setreadonly(c, true)
end
if _G.SmoothConfig.AntiAfk then
    a.Idled:Connect(
        function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end
    )
end
local function e()
    if _G.SmoothConfig.LowGraphic then
        settings().Rendering.QualityLevel = 1
        for f, g in pairs(game:GetDescendants()) do
            if g:IsA("BasePart") then
                g.Material = Enum.Material.SmoothPlastic
                g.CastShadow = false
            elseif g:IsA("Decal") or g:IsA("Texture") or g:IsA("ParticleEmitter") or g:IsA("Trail") then
                g:Destroy()
            elseif g:IsA("PostProcessEffect") then
                g.Enabled = false
            end
        end
        workspace.Terrain.WaterWaveSize = 0
        workspace.Terrain.WaterWaveSpeed = 0
        game:GetService("Lighting").GlobalShadows = false
    end
end
local function h()
    local i = a.Character and a.Character:FindFirstChild("HumanoidRootPart")
    if not i then
        return nil, 0
    end
    local j, k, l = nil, math.huge, 0
    for f, g in pairs(workspace:GetDescendants()) do
        if g:IsA("TouchTransmitter") and g.Parent and g.Parent.Name:lower():find("chest") then
            l = l + 1
            local m = (i.Position - g.Parent.Position).Magnitude
            if m < k then
                k = m
                j = g.Parent
            end
        end
    end
    return j, l
end
if b:FindFirstChild("EternalUI") then
    b.EternalUI:Destroy()
end
local n = Instance.new("ScreenGui", b)
n.Name = "EternalUI"
local o = Instance.new("Frame", n)
o.Size = UDim2.new(0, 220, 0, 100)
o.Position = UDim2.new(0.5, -110, 0.05, 0)
o.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
o.BorderSizePixel = 0
Instance.new("UICorner", o)
local p = Instance.new("TextButton", o)
p.Size = UDim2.new(0.9, 0, 0.4, 0)
p.Position = UDim2.new(0.05, 0, 0.1, 0)
p.Text = "AUTO FARM"
p.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
p.TextColor3 = Color3.new(1, 1, 1)
p.Font = Enum.Font.GothamBold
p.TextSize = 14
Instance.new("UICorner", p)
local q = Instance.new("TextLabel", o)
q.Size = UDim2.new(1, 0, 0.4, 0)
q.Position = UDim2.new(0, 0, 0.55, 0)
q.Text = "CHEST COUNT: 0"
q.TextColor3 = Color3.fromRGB(200, 200, 200)
q.Font = Enum.Font.GothamSemibold
q.BackgroundTransparency = 1
q.TextSize = 14
p.MouseButton1Click:Connect(
    function()
        _G.SmoothConfig.Enabled = not _G.SmoothConfig.Enabled
        p.Text = _G.SmoothConfig.Enabled and "FARMING..." or "AUTO FARM"
        p.BackgroundColor3 = _G.SmoothConfig.Enabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(40, 40, 40)
    end
)
task.spawn(
    function()
        while task.wait(_G.SmoothConfig.Speed) do
            local r, l = h()
            q.Text = "CHEST COUNT: " .. l
            if _G.SmoothConfig.Enabled and r and a.Character:FindFirstChild("HumanoidRootPart") then
                a.Character.HumanoidRootPart.CFrame = r.CFrame
                firetouchinterest(a.Character.HumanoidRootPart, r, 0)
                firetouchinterest(a.Character.HumanoidRootPart, r, 1)
            end
        end
    end)
e()
