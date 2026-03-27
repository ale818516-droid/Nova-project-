-- [[ PROYECTO NOVA: ELITE v14.0 SINGLE TAP ]] --
local P = game:GetService("Players")
local R = game:GetService("RunService")
local VU = game:GetService("VirtualUser")
local L = P.LocalPlayer
local C = workspace.CurrentCamera

_G.NE, _G.NS, _G.NSS = false, false, false
local LastShot = 0

-- Interfaz Nova
local G = Instance.new("ScreenGui", game:GetService("CoreGui"))
local M = Instance.new("TextButton", G)
M.Size, M.Position, M.Text = UDim2.new(0, 60, 0, 60), UDim2.new(0.1, 0, 0.5, 0), "N"
M.BackgroundColor3, M.TextColor3 = Color3.fromRGB(20, 20, 25), Color3.fromRGB(0, 255, 150)
Instance.new("UICorner", M).CornerRadius = UDim.new(1, 0)
M.Draggable = true

local F = Instance.new("Frame", M)
F.Size, F.Position, F.Visible = UDim2.new(0, 160, 0, 160), UDim2.new(1.2, 0, 0, 0), false
F.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Instance.new("UICorner", F).CornerRadius = UDim.new(0, 10)

local function CrearB(t, y, v)
    local b = Instance.new("TextButton", F)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, y)
    b.Text = t..": OFF"
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        _G[v] = not _G[v]
        b.Text = t..": "..(_G[v] and "ON" or "OFF")
        b.BackgroundColor3 = _G[v] and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(40, 40, 45)
    end)
end

CrearB("ESP", 10, "NE")
CrearB("SMART SHOT", 60, "NSS")
CrearB("SPEED", 110, "NS")

M.MouseButton1Click:Connect(function() F.Visible = not F.Visible end)

-- BUCLE PRINCIPAL
R.RenderStepped:Connect(function()
    -- ESP
    for _, p in pairs(P:GetPlayers()) do
        if p ~= L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local root = p.Character.HumanoidRootPart
            local esp = root:FindFirstChild("NovaESP")
            if _G.NE and p.Team ~= L.Team then
                if not esp then
                    esp = Instance.new("BoxHandleAdornment", root)
                    esp.Name, esp.AlwaysOnTop, esp.ZIndex, esp.Adornee = "NovaESP", true, 10, root
                    esp.Size, esp.Color3, esp.Transparency = root.Size * 1.5, Color3.fromRGB(255,0,0), 0.5
                end
            elseif esp then esp:Destroy() end
        end
    end

    -- SPEED (Velocity Bypass)
    if _G.NS and L.Character and L.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = L.Character.HumanoidRootPart
        local hum = L.Character.Humanoid
        hrp.Velocity = hum.MoveDirection * 100 + Vector3.new(0, hrp.Velocity.Y, 0)
    end

    -- SMART SHOT (Fusión Aim + Auto Click 1 Bala)
    if _G.NSS then
        local target, dist = nil, 500
        for _, p in pairs(P:GetPlayers()) do
            if p ~= L and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= L.Team then
                local d = (L.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then target, dist = p.Character.Head, d end
            end
        end

        if target then
            local pos, visible = C:WorldToViewportPoint(target.Position)
            if visible then
                -- Apuntar suavemente
                C.CFrame = C.CFrame:Lerp(CFrame.new(C.CFrame.Position, target.Position), 0.2)
                
                -- DISPARAR UNA SOLA BALA (con retardo para no vaciar el cargador)
                if tick() - LastShot > 0.3 then -- Dispara cada 0.3 segundos
                    VU:Button1Down(Vector2.new(0,0), C.CFrame)
                    task.wait(0.05)
                    VU:Button1Up(Vector2.new(0,0), C.CFrame)
                    LastShot = tick()
                end
            end
        end
    end
end) 