-- [[ PROYECTO NOVA: ELITE v20.0 KAVO EDITION ]] --
-- Replicando el estilo profesional de la foto

local P = game:GetService("Players")
local R = game:GetService("RunService")
local VU = game:GetService("VirtualUser")
local L = P.LocalPlayer
local C = workspace.CurrentCamera

-- Variables Globales para las funciones
_G.NovaESP = false
_G.NovaSpeed = false
_G.NovaAutoShot = false -- Para Sheriff (Pistola)
_G.NovaAutoClick = false -- Para Asesino (Cuchillo)

-- Cargar la Librería Kavo (Estilo Profesional)
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Crear la Ventana Principal (Estilo Oscuro como en la foto)
local Window = Kavo.CreateLib("Proyecto Nova - MVS Elite v20.0", "DarkTheme")

-- --- TAB PRINCIPAL (MAIN) ---
local MainTab = Window:NewTab("Principal")
local CombatSection = MainTab:NewSection("Combate")

-- Botón 1: ESP (Visuales)
CombatSection:NewToggle("Activar ESP", "Muestra cuadros rojos sobre los enemigos", function(state)
    _G.NovaESP = state
    if not state then
        -- Limpiar ESP si se desactiva
        for _, p in pairs(P:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local b = p.Character.HumanoidRootPart:FindFirstChild("NBox")
                if b then b:Destroy() end
            end
        end
    end
end)

-- Botón 2: AUTO SHOT (Sheriff) - Usa 'Activate'
CombatSection:NewToggle("Auto Shot (Sheriff)", "Apunta y dispara automáticamente con la pistola", function(state)
    _G.NovaAutoShot = state
    if state then
        Kavo:Notify("Modo Sheriff Activado", "Saca la pistola y acércate a los enemigos.")
    end
end)

-- Botón 3: AUTO CLICK (Asesino) - Usa 'VirtualUser'
CombatSection:NewToggle("Auto Click (Asesino)", "Ataca rápidamente con el cuchillo", function(state)
    _G.NovaAutoClick = state
    if state then
        Kavo:Notify("Modo Asesino Activado", "Saca el cuchillo para atacar sin parar.")
    end
end)

-- --- TAB DE MOVIMIENTO ---
local MoveTab = Window:NewTab("Movimiento")
local MoveSection = MoveTab:NewSection("Velocidad")

-- Control de Velocidad (Speed Hack)
MoveSection:NewToggle("Activar Speed Hack", "Aumenta la velocidad de movimiento", function(state)
    _G.NovaSpeed = state
end)

-- Slider para ajustar la fuerza de la velocidad (como el Aim Assist Strength de la foto)
MoveSection:NewSlider("Fuerza de Velocidad", "Ajusta qué tan rápido te mueves", 100, 10, function(s)
    L.Character.Humanoid.WalkSpeed = s
end)

-- --- LÓGICA DE EJECUCIÓN ---
R.Heartbeat:Connect(function()
    -- ESP
    for _, p in pairs(P:GetPlayers()) do
        if p ~= L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local root = p.Character.HumanoidRootPart
            if _G.NovaESP and p.Team ~= L.Team then
                if not root:FindFirstChild("NBox") then
                    local b = Instance.new("BoxHandleAdornment", root)
                    b.Name, b.AlwaysOnTop, b.Adornee, b.ZIndex = "NBox", true, root, 10
                    b.Size, b.Color3, b.Transparency = Vector3.new(3, 5, 1), Color3.fromRGB(255, 0, 0), 0.5
                end
            elseif root:FindFirstChild("NBox") then root.NBox:Destroy() end

            -- AUTO SHOT (Pistola)
            if _G.NovaAutoShot and p.Character:FindFirstChild("Head") and p.Team ~= L.Team then
                local _, vis = C:WorldToViewportPoint(p.Character.Head.Position)
                if vis then
                    -- Apuntado asistido
                    C.CFrame = C.CFrame:Lerp(CFrame.new(C.CFrame.Position, p.Character.Head.Position), 0.25)
                    local T = L.Character:FindFirstChildOfClass("Tool")
                    if T and T.Name:lower():find("pistol") or T.Name:lower():find("gun") then
                        T:Activate() -- Disparo directo
                    end
                end
            end
        end
    end

    -- AUTO CLICK (Cuchillo)
    if _G.NovaAutoClick then
        local T = L.Character:FindFirstChildOfClass("Tool")
        if T and T.Name:lower():find("knife") or T.Name:lower():find("sword") then
            VU:Button1Down(Vector2.new(0,0), C.CFrame)
            task.wait(0.05)
            VU:Button1Up(Vector2.new(0,0), C.CFrame)
        end
    end
end)
