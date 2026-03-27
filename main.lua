-- [[ PROYECTO NOVA: ELITE v10.0 ]] --
local P, R, VU = game:GetService("Players"), game:GetService("RunService"), game:GetService("VirtualUser")
local L = P.LocalPlayer
local C = workspace.CurrentCamera

_G.NE, _G.NA, _G.NS, _G.NAC = false, false, false, false

-- Crear Interfaz
local G = Instance.new("ScreenGui", game:GetService("CoreGui"))
local M = Instance.new("TextButton", G)
M.Size, M.Position, M.Text = UDim2.new(0, 60, 0, 60), UDim2.new(0.1, 0, 0.5, 0), "N"
M.BackgroundColor3, M.TextColor3 = Color3.fromRGB(20, 20, 25), Color3.fromRGB(0, 255, 150)
M.Font, M.TextSize, M.Draggable = Enum.Font.GothamBold, 28, true
Instance.new("UICorner", M).CornerRadius = UDim.new(1, 0)

local F = Instance.new("Frame", M)
F.Size, F.Position, F.Visible = UDim2.new(0, 160, 0, 210), UDim2.new(1.2, 0, 0, 0), false
F.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Instance.new("UICorner", F).CornerRadius = UDim.new(0, 10)

local function CrearB(t, y, v)
    local b = Instance.new("TextButton", F)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, y)
    b.Text, b.BackgroundColor3 = t..": OFF", Color3.fromRGB(40, 40, 45)
    b.TextColor3, b.Font = Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        _G[v] = not _G[v]
        b.Text = t..": "..(_G[v] and "ON" or "OFF")
        b.BackgroundColor3 = _G[v] and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(40, 40, 45)
    end)
end

CrearB("ESP", 10, "NE")
CrearB("AIM & SHOOT", 60, "NA")
CrearB("SPEED", 110, "NS")
CrearB("AUTO CLICK", 160, "NAC")

M.MouseButton1Click:Connect(function() F.Visible = not F.Visible end)

-- Bucle Principal
R.RenderStepped:Connect(function()
    -- ESP
    if _G.NE then
        for _, p in pairs(P:GetPlayers()) do
            if p ~= L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local root = p.Character.HumanoidRootPart
                if not root:FindFirstChild("NovaBox") and p.Team ~= L.Team then
                    local b = Instance.new("BoxHandleAdornment", root)
                    b.Name, b.AlwaysOnTop, b.ZIndex = "NovaBox", true, 5
                    b.Size, b.Color3, b.Transparency, b.Adornee = p.Character:GetExtentsSize(), Color3.fromRGB(255, 0, 0), 0.6, root
                end
            end
        end
    end
    -- Speed
    if L.Character and L.Character:FindFirstChild("Humanoid") then
        L.Character.Humanoid.WalkSpeed = _G.NS and 120 or 16
    end
    -- Aim & Smart Shoot
    if _G.NA then
        local target, dist = nil, 500
        for _, p in pairs(P:GetPlayers()) do
            if p ~= L and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= L.Team then
                local d = (L.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then target, dist = p.Character.Head, d end
            end
        end
        if target then
            C.CFrame = CFrame.new(C.CFrame.Position, target.Position)
            local _, vis = C:WorldToViewportPoint(target.Position)
            if vis then VU:Button1Down(Vector2.new(0,0), C.CFrame) else VU:Button1Up(Vector2.new(0,0), C.CFrame) end
        else VU:Button1Up(Vector2.new(0,0), C.CFrame) end
    end
    -- Auto Click
    if _G.NAC then VU:Button1Down(Vector2.new(0,0), C.CFrame) task.wait() VU:Button1Up(Vector2.new(0,0), C.CFrame) end
end) 