-- [[ PROYECTO NOVA: v27.0 POWER EDITION ]] --
local P = game:GetService("Players")
local R = game:GetService("RunService")
local L = P.LocalPlayer
local C = workspace.CurrentCamera

-- Variables de estado (Todo apagado al inicio)
_G.NovaESP = false
_G.NovaAim = false
_G.NovaSpeed = false

-- INTERFAZ QUE NO SE ROMPE
local G = Instance.new("ScreenGui", L:WaitForChild("PlayerGui"))
G.Name = "NovaMVS"
G.ResetOnSpawn = false

local M = Instance.new("Frame", G)
M.Size, M.Position = UDim2.new(0, 150, 0, 220), UDim2.new(0.02, 0, 0.3, 0)
M.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
M.Active, M.Draggable = true, true
Instance.new("UICorner", M)

local Title = Instance.new("TextLabel", M)
Title.Size, Title.Text = UDim2.new(1, 0, 0, 30), "NOVA ELITE"
Title.TextColor3, Title.BackgroundTransparency = Color3.fromRGB(0, 255, 150), 1

local function CrearBoton(txt, y, var)
    local b = Instance.new("TextButton", M)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0, y)
    b.Text = txt..": OFF"
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        _G[var] = not _G[var]
        b.Text = txt..": "..(_G[var] and "ON" or "OFF")
        b.BackgroundColor3 = _G[var] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(30, 30, 35)
    end)
end

CrearBoton("ESP PRO", 40, "NovaESP")
CrearBoton("AUTO SHOT", 90, "NovaAim")
CrearBoton("SPEED", 140, "NovaSpeed")

-- BOTON DE PANICO (Desactiva todo y cierra el menu)
local X = Instance.new("TextButton", M)
X.Size, X.Position, X.Text = UDim2.new(0.9, 0, 0, 30), UDim2.new(0.05, 0, 0, 185), "CERRAR SCRIPT"
X.BackgroundColor3, X.TextColor3 = Color3.fromRGB(150, 0, 0), Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", X)
X.MouseButton1Click:Connect(function() G:Destroy() _G.NovaESP = false _G.NovaAim = false _G.NovaSpeed = false end)

-- LÓGICA DE ALTA EFECTIVIDAD PARA MVS
R.RenderStepped:Connect(function()
    if _G.NovaSpeed and L.Character and L.Character:FindFirstChild("Humanoid") then
        L.Character.Humanoid.WalkSpeed = 25 -- Velocidad optimizada para MVS
    end

    for _, p in pairs(P:GetPlayers()) do
        if p ~= L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local root = p.Character.HumanoidRootPart
            local head = p.Character:FindFirstChild("Head")

            -- ESP (Highlight: Lo más efectivo en 2026)
            if _G.NovaESP and p.Team ~= L.Team then
                if not root:FindFirstChild("N_ESP") then
                    local h = Instance.new("Highlight", root)
                    h.Name, h.FillColor = "N_ESP", Color3.fromRGB(255, 0, 0)
                end
            elseif root:FindFirstChild("N_ESP") then root.N_ESP:Destroy() end

            -- AUTO SHOT (Fuerza de Aim al 70%)
            if _G.NovaAim and p.Team ~= L.Team and head then
                local _, vis = C:WorldToViewportPoint(head.Position)
                if vis then
                    -- Esto fuerza a la cámara a mirar a la cabeza
                    C.CFrame = C.CFrame:Lerp(CFrame.new(C.CFrame.Position, head.Position), 0.2)
                    
                    -- Disparo Automático (Detecta cualquier arma)
                    local tool = L.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
            end
        end
    end
end)
