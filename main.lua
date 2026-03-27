-- [[ PROYECTO NOVA: v23.0 GHOST EDITION ]] --
local P = game:GetService("Players")
local R = game:GetService("RunService")
local L = P.LocalPlayer
local C = workspace.CurrentCamera
local VIM = game:GetService("VirtualInputManager")

_G.NE, _G.NS, _G.NAS, _G.NAC = false, false, false, false

-- Interfaz Minimalista (Estilo Ghost)
local G = Instance.new("ScreenGui", L:WaitForChild("PlayerGui"))
G.Name = "NovaGhost"
local M = Instance.new("TextButton", G)
M.Size, M.Position, M.Text = UDim2.new(0, 40, 0, 40), UDim2.new(0, 10, 0, 10), "N"
M.BackgroundColor3, M.BackgroundTransparency = Color3.fromRGB(10, 10, 15), 0.6
M.TextColor3 = Color3.fromRGB(0, 255, 150)
Instance.new("UICorner", M).CornerRadius = UDim.new(1, 0)
M.Draggable = true

local F = Instance.new("Frame", M)
F.Size, F.Position, F.Visible = UDim2.new(0, 140, 0, 190), UDim2.new(1.2, 0, 0, 0), false
F.BackgroundColor3, F.BackgroundTransparency = Color3.fromRGB(5, 5, 5), 0.2
Instance.new("UICorner", F)

local function CrearB(t, y, v)
    local b = Instance.new("TextButton", F)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 35), UDim2.new(0.05, 0, 0, y)
    b.Text, b.BackgroundColor3 = t, Color3.fromRGB(30, 30, 35)
    b.TextColor3 = Color3.fromRGB(200, 200, 200)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        _G[v] = not _G[v]
        b.TextColor3 = _G[v] and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(200, 200, 200)
    end)
end

CrearB("ESP GHOST", 10, "NE")
CrearB("SMOOTH AIM", 55, "NAS")
CrearB("AUTO SLICE", 100, "NAC")
CrearB("GHOST SPEED", 145, "NS")

M.MouseButton1Click:Connect(function() F.Visible = not F.Visible end)

-- LÓGICA DE ALTA EFECTIVIDAD
R.Heartbeat:Connect(function()
    -- GHOST SPEED (Bypass por Vector de Fuerza)
    if _G.NS and L.Character and L.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = L.Character.HumanoidRootPart
        local hum = L.Character.Humanoid
        if hum.MoveDirection.Magnitude > 0 then
            hrp.Velocity = Vector3.new(hum.MoveDirection.X * 55, hrp.Velocity.Y, hum.MoveDirection.Z * 55)
        end
    end

    for _, p in pairs(P:GetPlayers()) do
        if p ~= L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local root = p.Character.HumanoidRootPart
            
            -- ESP GHOST (BillboardGui: Indetectable)
            if _G.NE and p.Team ~= L.Team then
                if not root:FindFirstChild("NovaG") then
                    local bg = Instance.new("BillboardGui", root)
                    bg.Name, bg.AlwaysOnTop, bg.Size = "NovaG", true, UDim2.new(0, 50, 0, 50)
                    local frame = Instance.new("Frame", bg)
                    frame.Size, frame.BackgroundColor3, frame.BorderSizePixel = UDim2.new(1, 0, 1, 0), Color3.fromRGB(255, 0, 0), 0
                    Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
                    frame.BackgroundTransparency = 0.6
                end
            elseif root:FindFirstChild("NovaG") then root.NovaG:Destroy() end

            -- SMOOTH AIM (Apunta sin que se note)
            if _G.NAS and p.Team ~= L.Team and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                local _, vis = C:WorldToViewportPoint(head.Position)
                if vis then
                    C.CFrame = C.CFrame:Lerp(CFrame.new(C.CFrame.Position, head.Position), 0.12) -- Muy suave
                    local tool = L.Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end
            end
        end
    end

    -- AUTO SLICE (Para el Asesino)
    if _G.NAC then
        VIM:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.02)
        VIM:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end
end)
