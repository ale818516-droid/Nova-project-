-- 1. Carga de Librería
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/azurelw/azurehub/refs/heads/main/main.lua"))()

-- 2. Variables Globales
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local SelectedTargetName = nil -- Guardamos el nombre en lugar del objeto
_G.AutoTeleport = false
_G.SuperBypass = false

-- 3. Ventana y Pestaña
local Window = WindUI:CreateWindow({ Title = "ALEXX HUB", Icon = "apple" })
local MoveTab = Window:Tab({ Title = "Bypass Movimiento 🔓", Icon = "move" })

-- Función para actualizar lista
local function GetPlayerList()
    local list = {}
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= localPlayer then table.insert(list, v.Name) end
    end
    return #list > 0 and list or {"Esperando jugadores..."}
end

-- 4. Dropdown de Selección
local PlayerDropdown = MoveTab:Dropdown({
    Title = "Seleccionar Jugador",
    List = GetPlayerList(),
    Callback = function(Option)
        SelectedTargetName = Option -- Guardamos el nombre como referencia constante
    end
})

-- Botón para refrescar
MoveTab:Button({
    Title = "🔄 Refrescar Lista",
    Callback = function() PlayerDropdown:Refresh(GetPlayerList()) end
})

-- 5. Bucle de Seguimiento Inteligente (Persistente en rondas)
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoTeleport and SelectedTargetName then
            -- Buscamos al jugador por nombre en cada ciclo (evita errores de ronda)
            local player = Players:FindFirstChild(SelectedTargetName)
            local char = player and player.Character
            local hum = char and char:FindFirstChild("Humanoid")
            local myHRP = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetHRP = char and char:FindFirstChild("HumanoidRootPart")
            
            -- Si el jugador está vivo, procedemos
            if player and char and hum and hum.Health > 0 and targetHRP and myHRP then
                -- Solo teletransporta si estás lejos (más de 5 studs)
                local distancia = (myHRP.Position - targetHRP.Position).Magnitude
                if distancia > 5 then
                    myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 3)
                end
            end
        end
    end
end)

MoveTab:Toggle({
    Title = "🔥 Activar Seguimiento Auto",
    Value = false,
    Callback = function(state)
        _G.AutoTeleport = state
    end
})

-- 6. Anti-Freeze
MoveTab:Toggle({
    Title = "❄️ Anti-Freeze",
    Value = false,
    Callback = function(state)
        _G.SuperBypass = state
        if state then
            task.spawn(function()
                while _G.SuperBypass do
                    pcall(function()
                        local char = localPlayer.Character
                        if char then
                            for _, v in pairs(char:GetDescendants()) do
                                if v:IsA("BasePart") then v.Anchored = false end
                            end
                            local hum = char:FindFirstChild("Humanoid")
                            if hum and hum.WalkSpeed < 10 then hum.WalkSpeed = 16 end
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- Refresco inicial
task.spawn(function() task.wait(2) PlayerDropdown:Refresh(GetPlayerList()) end)
