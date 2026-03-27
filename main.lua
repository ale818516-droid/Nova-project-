-- [[ PROYECTO NOVA: ELITE v16.0 FAST-DEX STYLE ]] --
local P = game:GetService("Players")
local R = game:GetService("RunService")
local L = P.LocalPlayer
local C = workspace.CurrentCamera

_G.NE, _G.NS, _G.NSS = false, false, false

-- Interfaz Profesional
local G = Instance.new("ScreenGui", L:WaitForChild("PlayerGui"))
G.Name = "NovaPro"
local M = Instance.new("TextButton", G)
M.Size, M.Position, M.Text = UDim2.new(0, 55, 0, 55), UDim2.new(0.05, 0, 0.4, 0), "N"
M.BackgroundColor3, M.TextColor3 = Color3.fromRGB(25, 25, 30), Color3.fromRGB(0, 255, 150)
Instance.new("UICorner", M).CornerRadius = UDim.new(1, 0)
M.Draggable = true

local F = Instance.new("Frame", M)
F.Size, F.Position, F.Visible = UDim2.new(0, 160, 0, 180), UDim2.new(1.2, 0, 0, 0), false
F.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Instance.new("UICorner", F)

local function Boton(t, y, v)
    local b = Instance.new("TextButton", F)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, y)
    b.Text = t..": OFF"
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        _G[v] = not _G[v]
        b.Text = t..": "..(_G[v] and "ON" or "OFF")
        b.BackgroundColor3 = _G[v] and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(40, 40, 45)
    end)
end

Boton("ESP", 10, "NE")
Boton("SMART SHOT", 60, "NSS")
Boton("SPEED", 110, "NS")

M.MouseButton1Click:Connect(function() F.Visible = not F.Visible end)

-- FUNCION DE DISPARO FORZADO (Estilo FastDex)
local function Disparar()
    local Tool = L.Character:FindFirstChildOfClass("Tool") or L.Backpack:FindFirstChildOfClass("Tool")
    if Tool then
        Tool:Activate() -- Esto activa el arma directamente sin usar clicks
    end
end

R.Heartbeat:Connect(function()
    -- SPEED (Bypass)
    if _G.NS and L.Character and L.Character:FindFirstChild("HumanoidRootPart") then
        L.Character.HumanoidRootPart.CFrame = L.Character.HumanoidRootPart.CFrame + (L.Character.Humanoid.MoveDirection * 1.1)
    end

    -- ESP Y SMART SHOT
    for _, p in pairs(P:GetPlayers()) do
        if p ~= L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local root = p.Character.HumanoidRootPart
            
            -- ESP
            if _G.NE then
                if not root:FindFirstChild("NBox") then
                    local b = Instance.new("BoxHandleAdornment", root)
                    b.Name, b.AlwaysOnTop, b.Adornee, b.ZIndex = "NBox", true, root, 10
                    b.Size, b.Color3, b.Transparency = Vector3.new(3, 5, 1), Color3.fromRGB(255, 0, 0), 0.5
                end
            elseif root:FindFirstChild("NBox") then root.NBox:Destroy() end

            -- SMART SHOT (Aim Assist)
            if _G.NSS and p.Team ~= L.Team then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    local _, vis = C:WorldToViewportPoint(head.Position)
                    if vis then
                        C.CFrame = C.CFrame:Lerp(CFrame.new(C.CFrame.Position, head.Position), 0.25)
                        Disparar() -- Llama a la funcion de disparo directo
                    end
                end
            end
        end
    end
end)
