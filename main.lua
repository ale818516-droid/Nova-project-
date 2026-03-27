-- [[ PROYECTO NOVA: FULL ELITE v3 ]] --
local P = game:GetService("Players")
local R = game:GetService("RunService")
local L = P.LocalPlayer
local C = workspace.CurrentCamera
local VU = game:GetService("VirtualUser")

_G.NovaE, _G.NovaA, _G.NovaS, _G.NovaAC = false, false, false, false

local G = Instance.new("ScreenGui", game:GetService("CoreGui"))
local M = Instance.new("TextButton", G)
M.Size, M.Position, M.Text = UDim2.new(0, 55, 0, 55), UDim2.new(0.1, 0, 0.5, 0), "N"
M.BackgroundColor3, M.TextColor3 = Color3.fromRGB(15, 15, 20), Color3.fromRGB(0, 255, 150)
Instance.new("UICorner", M).CornerRadius = UDim.new(1, 0)
M.Draggable = true

local F = Instance.new("Frame", M)
F.Size, F.Position, F.Visible = UDim2.new(0, 160, 0, 200), UDim2.new(1.2, 0, 0, 0), false
F.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8)

local function CrearB(txt, y, var)
    local b = Instance.new("TextButton", F)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 35), UDim2.new(0.05, 0, 0, y)
    b.Text, b.BackgroundColor3 = txt..": OFF", Color3.fromRGB(30, 30, 35)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        _G[var] = not _G[var]
        b.Text = txt..": "..(_G[var] and "ON" or "OFF")
        b.BackgroundColor3 = _G[var] and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(30, 30, 35)
    end)
end

CrearB("ESP", 10, "NovaE")
CrearB("AIM & SHOOT", 50, "NovaA")
CrearB("SPEED", 90, "NovaS")
CrearB("AUTO CLICK", 130, "NovaAC")

M.MouseButton1Click:Connect(function() F.Visible = not F.Visible end)

R.RenderStepped:Connect(function()
    if _G.NovaE then
        for _, p in pairs(P:GetPlayers()) do
            if p ~= L and p.Character then
                local h = p.Character:FindFirstChild("NH")
                if p.Team ~= L.Team then
                    if not h then h = Instance.new("Highlight", p.Character) h.Name = "NH" h.FillColor = Color3.fromRGB(255, 0, 0) end
                end
            end
        end
    end
    if L.Character and L.Character:FindFirstChild("Humanoid") then
        L.Character.Humanoid.WalkSpeed = _G.NovaS and 100 or 16
    end
    if _G.NovaA then
        local t, d = nil, 500
        for _, p in pairs(P:GetPlayers()) do
            if p ~= L and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= L.Team then
                local dist = (L.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist < d then t, d = p.Character.Head, dist end
            end
        end
        if t then 
            C.CFrame = CFrame.new(C.CFrame.Position, t.Position)
            VU:Button1Down(Vector2.new(0,0), C.CFrame)
        end
    end
    if _G.NovaAC then VU:Button1Down(Vector2.new(0,0), C.CFrame) end
end)
