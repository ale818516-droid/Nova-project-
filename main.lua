-- [[ PROYECTO NOVA: ELITE v15.0 FINAL FORCE ]] --
local P = game:GetService("Players")
local R = game:GetService("RunService")
local L = P.LocalPlayer
local C = workspace.CurrentCamera

_G.NE, _G.NS, _G.NSS = false, false, false

-- Interfaz en PlayerGui (Más difícil de bloquear)
local G = Instance.new("ScreenGui", L:WaitForChild("PlayerGui"))
G.Name = "NovaPanel"
G.ResetOnSpawn = false

local M = Instance.new("TextButton", G)
M.Size, M.Position, M.Text = UDim2.new(0, 50, 0, 50), UDim2.new(0.05, 0, 0.4, 0), "N"
M.BackgroundColor3, M.TextColor3 = Color3.fromRGB(30, 30, 35), Color3.fromRGB(0, 255, 150)
Instance.new("UICorner", M).CornerRadius = UDim.new(1, 0)
M.Active = true
M.Draggable = true

local F = Instance.new("Frame", M)
F.Size, F.Position, F.Visible = UDim2.new(0, 150, 0, 180), UDim2.new(1.2, 0, 0, 0), false
F.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", F)

local function Boton(t, y, v)
    local b = Instance.new("TextButton", F)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, y)
    b.Text, b.BackgroundColor3 = t..": OFF", Color3.fromRGB(50, 50, 55)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        _G[v] = not _G[v]
        b.Text = t..": "..(_G[v] and "ON" or "OFF")
        b.BackgroundColor3 = _G[v] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 50, 55)
    end)
end

Boton("ESP", 10, "NE")
Boton("SMART SHOT", 60, "NSS")
Boton("SPEED", 110, "NS")

M.MouseButton1Click:Connect(function() F.Visible = not F.Visible end)

-- Motor del Script
R.Heartbeat:Connect(function()
    -- SPEED (Bypass por Posición Relativa)
    if _G.NS and L.Character and L.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = L.Character.HumanoidRootPart
        local hum = L.Character.Humanoid
        if hum.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * 1.2)
        end
    end

    -- ESP Y DISPARO
    for _, p in pairs(P:GetPlayers()) do
        if p ~= L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local root = p.Character.HumanoidRootPart
            local head = p.Character:FindFirstChild("Head")
            
            -- ESP Forzado
            if _G.NE and p.Team ~= L.Team then
                if not root:FindFirstChild("NBox") then
                    local b = Instance.new("BoxHandleAdornment", root)
                    b.Name, b.AlwaysOnTop, b.ZIndex, b.Adornee = "NBox", true, 10, root
                    b.Size, b.Color3, b.Transparency = root.Size * 2.2, Color3.fromRGB(255, 0, 0), 0.6
                end
            elseif root:FindFirstChild("NBox") then root.NBox:Destroy() end

            -- SMART SHOT (Enfoque + 1 Bala)
            if _G.NSS and head and p.Team ~= L.Team then
                local _, vis = C:WorldToViewportPoint(head.Position)
                if vis then
                    local dist = (L.Character.HumanoidRootPart.Position - root.Position).Magnitude
                    if dist < 300 then
                        C.CFrame = CFrame.new(C.CFrame.Position, head.Position)
                        -- Simulación de toque directo en pantalla
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        task.wait(0.05)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    end
                end
            end
        end
    end
end)
