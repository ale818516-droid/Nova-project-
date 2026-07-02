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

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoTeleport and SelectedTargetName then
            local player = game:GetService("Players"):FindFirstChild(SelectedTargetName)
            local char = player and player.Character
            local targetHRP = char and char:FindFirstChild("HumanoidRootPart")
            local myHRP = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            -- Si el personaje es nuevo (nueva ronda o respawn) y no es el que ya guardamos
            if char and targetHRP and myHRP and char ~= LastTeleportedCharacter then
                -- Teletransporta una vez
                myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 3)
                
                -- Guarda este personaje para NO volver a teletransportar hasta que sea uno nuevo
                LastTeleportedCharacter = char
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

-- === 1. LÓGICA DE DETECCIÓN (Mejorada) ===
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function isEnemy(player)
    if player == LocalPlayer then return false end
    
    local myTeam = LocalPlayer:GetAttribute("Team")
    local targetTeam = player:GetAttribute("Team")
    if myTeam and targetTeam then
        return myTeam ~= targetTeam
    end
    
    if LocalPlayer.Team and player.Team then
        return LocalPlayer.Team ~= player.Team
    end
    
    return false -- Ajustado para juegos de equipo (MM2, etc)
end

-- === 2. INTERFAZ ===
local HitboxTab = Window:Tab({ Title = "Combate ⚔️", Icon = "sword" })

getgenv().HitboxSize = 10 -- Valor por defecto

HitboxTab:Slider({
    Title = "Tamaño Hitbox",
    Value = { Min = 1, Max = 100, Default = 10 },
    Callback = function(v) getgenv().HitboxSize = v end
})

HitboxTab:Toggle({
    Title = "Activar Hitbox",
    Value = false,
    Callback = function(state) getgenv().HitboxEnabled = state end
})

HitboxTab:Toggle({
    Title = "Activar ESP",
    Value = false,
    Callback = function(state) getgenv().EspEnabled = state end
})

-- === 3. BUCLE HITBOX (Independiente y con Limpieza) ===
task.spawn(function()
    while true do
        task.wait(0.2)
        if getgenv().HitboxEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                local char = player.Character
                local hum = char and char:FindFirstChild("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if char and hum and hum.Health > 0 and hrp and isEnemy(player) then
                    hrp.Size = Vector3.new(getgenv().HitboxSize, getgenv().HitboxSize, getgenv().HitboxSize)
                    hrp.Transparency = 0.5
                    hrp.CanCollide = false
                    hrp.Material = Enum.Material.Neon
                else
                    -- Limpiamos solo si el tamaño está alterado
                    if hrp and hrp.Size ~= Vector3.new(2, 2, 1) then
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                end
            end
        else
            -- === ESTA ES LA PARTE QUE FALTABA ===
            -- Esto se ejecuta cuando apagas el Toggle
            for _, player in pairs(Players:GetPlayers()) do
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp and hrp.Size ~= Vector3.new(2, 2, 1) then
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end
    end
end)


-- === 4. BUCLE ESP (Independiente) ===
task.spawn(function()
    while true do
        task.wait(0.5)
        for _, player in pairs(Players:GetPlayers()) do
            local char = player.Character
            local hum = char and char:FindFirstChild("Humanoid")
            
            if getgenv().EspEnabled and char and hum and hum.Health > 0 and isEnemy(player) then
                if not char:FindFirstChild("EspHighlight") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "EspHighlight"
                    hl.Parent = char
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                end
            else
                if char and char:FindFirstChild("EspHighlight") then
                    char.EspHighlight:Destroy()
                end
            end
        end
    end
end)
