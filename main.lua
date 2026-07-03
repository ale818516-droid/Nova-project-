-- 1. Carga de Librería
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/azurelw/azurehub/refs/heads/main/main.lua"))()

-- 2. Variables Globales
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local SelectedTargetName = nil -- Guardamos el nombre en lugar del objeto
_G.AutoTeleport = false
_G.SuperBypass = false
local Drawing = Drawing -- Asegúrate de que tu executor lo soporte
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1.5
fovCircle.Color = Color3.fromRGB(255, 0, 0)
fovCircle.Filled = false
fovCircle.Visible = false

getgenv().SilentAim = {
    Enabled = false,
    FOV = 150,
    Prediction = 0.1, -- 0.1 es el estándar para velocidad
    Dist = 300
}

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
    Title = "Teletransport Player",
    Value = false,
    Callback = function(state)
        _G.AutoTeleport = state
    end
})

-- 6. Anti-Freeze
MoveTab:Toggle({
    Title = "Anti Contador",
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
    Value = { Min = 1, Max = 20, Default = 1 },
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

-- === 3. BUCLE HITBOX (Ahora respeta a la Pro para evitar parpadeo) ===
task.spawn(function()
    while true do
        task.wait(0.2)
        -- Solo ejecutamos esto si Hitbox Pro NO está encendida
        if getgenv().HitboxEnabled and not getgenv().Hitbox2_Enabled then
            for _, player in pairs(Players:GetPlayers()) do
                local char = player.Character
                local hum = char and char:FindFirstChild("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if char and hum and hum.Health > 0 and hrp and isEnemy(player) then
                    hrp.Size = Vector3.new(getgenv().HitboxSize, getgenv().HitboxSize, getgenv().HitboxSize)
                    hrp.Transparency = 0.5
                    hrp.CanCollide = false
                    hrp.Material = Enum.Material.Neon
                elseif hrp and hrp.Size ~= Vector3.new(2, 2, 1) then
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        elseif not getgenv().Hitbox2_Enabled then
            -- Solo reseteamos si NO estamos en modo Pro
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

-- === PESTAÑA Y LÓGICA HITBOX PRO ===
local HitboxProTab = Window:Tab({ Title = "Hitbox Disimulada🎯", Icon = "target" })

-- Slider exclusivo para Hitbox Pro
HitboxProTab:Slider({
    Title = "Tamaño Hitbox Pro",
    Value = { Min = 1, Max = 20, Default = 1},
    Callback = function(v) getgenv().HitboxSize2 = v end
})

-- Toggle exclusivo para Hitbox Pro
HitboxProTab:Toggle({
    Title = "Activar Hitbox Pro (Paredes)",
    Value = false,
    Callback = function(state) getgenv().Hitbox2_Enabled = state end
})

-- Bucle exclusivo (Solo se activa si el toggle anterior está en ON)
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Hitbox2_Enabled then
            local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            for _, player in pairs(Players:GetPlayers()) do
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChild("Humanoid")
                
                if char and hum and hum.Health > 0 and hrp and isEnemy(player) then
                    -- Raycast para detectar pared
                    local isVisible = true
                    if myHRP then
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {LocalPlayer.Character, workspace.CurrentCamera}
                        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                        local ray = workspace:Raycast(myHRP.Position, (hrp.Position - myHRP.Position), rayParams)
                        
                        if ray and not ray.Instance:IsDescendantOf(char) then
                            isVisible = false
                        end
                    end
                    
                    -- Aplicar tamaño solo si es visible
                    if isVisible then
                        hrp.Size = Vector3.new(getgenv().HitboxSize2, getgenv().HitboxSize2, getgenv().HitboxSize2)
                        hrp.Transparency = 0.5
                        hrp.Material = Enum.Material.Neon
                        hrp.Color = Color3.fromRGB(255, 0, 0)
                        hrp.CanCollide = false
                    else
                        -- Reset si está detrás de pared
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                end
            end
        end
    end
end)

-- ====================================================================
-- LÓGICA ORIGINAL (IDÉNTICA A TU REFERENCIA)
-- ====================================================================

-- Creamos un Mouse falso para que la lógica de tu script original no falle al buscar "Mouse.Hit"
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse() -- Aunque estés en móvil, esto inicializa la propiedad en la mayoría de ejecutores

getgenv().SilentAim = {
    Enabled = false,
    FOV = 150,
    Prediction = 100, -- Mantenemos el valor base de tu script (100)
    Part = "Head"
}

local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1.5
fovCircle.Color = Color3.fromRGB(220, 20, 20)
fovCircle.Filled = false
fovCircle.Visible = false

local function getClosest()
    local targetPart, targetPlayer, closest = nil, nil, getgenv().SilentAim.FOV
    local Cam = workspace.CurrentCamera
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local char = p.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local part = char:FindFirstChild(getgenv().SilentAim.Part)
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            if part and hrp and hum and hum.Health > 0 then
                -- MEJORA: Aumentamos el IgnoreList para incluir todo tu modelo
                local ray = Ray.new(Cam.CFrame.Position, (part.Position - Cam.CFrame.Position).Unit * 500)
                local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Cam})
                
                -- RELAJAMOS EL WALLCHECK: Si el hit es parte del enemigo O está muy cerca, lo toma como válido
                local isVisible = hit and hit:IsDescendantOf(char)
                
                if isVisible then
                    local screenPos, onScreen = Cam:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local mouseDist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)).Magnitude
                        if mouseDist < closest then
                            closest = mouseDist 
                            targetPart = part 
                            targetPlayer = p 
                        end
                    end
                end
            end
        end
    end
    return targetPart, targetPlayer
end


-- El Hook corregido (para que no bloquee los disparos)
if hookmetamethod and checkcaller then
    local oldIndex
    oldIndex = hookmetamethod(game, "__index", function(self, index)
        -- Si el SilentAim está desactivado, o no es el Mouse, o no es la propiedad Hit, regresamos a lo normal inmediatamente
        if not getgenv().SilentAim.Enabled or self ~= Mouse or index ~= "Hit" or checkcaller() then
            return oldIndex(self, index)
        end

        local targetPart, targetPlayer = getClosest()
        
        -- Si encontramos un objetivo, devolvemos la posición predicha
        if targetPart and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local predFactor = getgenv().SilentAim.Prediction / 100 
            return CFrame.new(targetPart.Position + targetPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity * 0.08 * predFactor)
        end

        -- IMPORTANTE: Si NO hay objetivo, debemos devolver el Mouse.Hit original 
        -- para que puedas seguir disparando normalmente al aire o a donde quieras
        return oldIndex(self, index)
    end)
end

-- Bucle de renderizado del círculo (en medio)
game:GetService("RunService").RenderStepped:Connect(function()
    fovCircle.Visible = getgenv().SilentAim.Enabled
    fovCircle.Radius = getgenv().SilentAim.FOV
    fovCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
end)


local AimTab = Window:Tab({ Title = "Silent Aim 🎯", Icon = "crosshair" })

AimTab:Toggle({
    Title = "Activar Silent Aim",
    Value = false,
    Callback = function(v) getgenv().SilentAim.Enabled = v end
})

AimTab:Slider({
    Title = "Radio FOV",
    Value = { Min = 30, Max = 800, Default = 150 },
    Callback = function(v) getgenv().SilentAim.FOV = v end
})

AimTab:Slider({
    Title = "Predicción",
    Value = { Min = 0, Max = 100, Default = 100 },
    Callback = function(v) getgenv().SilentAim.Prediction = v end
})

-- === NOCLIP Y LIBERTAD DE MOVIMIENTO (SIN TOCAR CÁMARA) ===
local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local noclip = false

-- Esta función hace que tu personaje sea "fantasma" y atraviese todo
runService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- === INTEGRACIÓN EN TU HUB ===
local LocalTab = Window:Tab({ Title = "Players", Icon = "map" })

LocalTab:Toggle({
    Title = "Atravesar Paredes",
    Callback = function(state)
        noclip = state
        -- Si desactivas el Noclip, devolvemos la colisión para no caer al vacío
        if not state and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
})
-- === CONTROLES SPEED (LocalTab) ===
_G.SpeedEnabled = false
_G.SpeedMultiplier = 0

LocalTab:Toggle({
    Title = "Activar Speed",
    Default = false,
    Callback = function(state)
        _G.SpeedEnabled = state
    end
})

LocalTab:Slider({
    Title = "Speed Slider",
    Value = { Min = 0, Max = 100, Default = 0 },
    Callback = function(v) 
        _G.SpeedMultiplier = v / 100 
    end
})

-- === LÓGICA SPEED (Indetectable) ===
game:GetService("RunService").RenderStepped:Connect(function()
    -- Solo ejecuta si el toggle está activo Y hay velocidad asignada
    if _G.SpeedEnabled and _G.SpeedMultiplier > 0 then
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if hrp and hum and hum.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * _G.SpeedMultiplier)
        end
    end
end)

_G.InfiniteJump = false

LocalTab:Toggle({
    Title = "Salto Infinito",
    Default = false,
    Callback = function(state)
        _G.InfiniteJump = state
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfiniteJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- === CAMBIADOR DE FOV CON TOGGLE ===
_G.FOVEnabled = false
local Camera = workspace.CurrentCamera
local DefaultFOV = 70 -- Valor base

LocalTab:Toggle({
    Title = "Activar FOV",
    Default = false,
    Callback = function(state)
        _G.FOVEnabled = state
        if not state then
            Camera.FieldOfView = DefaultFOV -- Regresa a 70 al desactivar
        end
    end
})

LocalTab:Slider({
    Title = "Valor FOV",
    Value = { Min = 70, Max = 120, Default = 70 },
    Callback = function(v)
        if _G.FOVEnabled then
            Camera.FieldOfView = v
        end
    end
})

-- 1. La variable global para controlar el estado
_G.WallClimb = false

-- 2. El Toggle en tu LocalTab
LocalTab:Toggle({
    Title = "Wall Climb",
    Default = false,
    Callback = function(state)
        _G.WallClimb = state
    end
})

-- 3. La lógica que corre constantemente en segundo plano
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.WallClimb then
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        -- Verifica si te estás moviendo contra una pared (MoveDirection.Magnitude > 0)
        if hum and hrp and hum.MoveDirection.Magnitude > 0 then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 25, hrp.Velocity.Z)
        end
    end
end)
