-- REPARA EL ERROR DE INICIO: Define la tabla Settings que eliminaste
local Settings = {
    AutoTeleport = false,
    SilentAim = false,
    SilentAim_FOV = 150,
    SilentAim_Prediction = 100,
    SilentAim_Part = "Head",
    SilentAim_HideFOV = false,
    HitboxEnabled = false,
    EspEnabled = false,
    Hitbox2_Enabled = false,
    SpeedEnabled = false,
    InfiniteJump = false,
    FOVEnabled = false,
    WallClimb = false
}

-- Función vacía de Save para que no dé error al presionar botones
local function Save() 
    -- Si no quieres guardar, esto evita que el script se cierre por error
end


local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/azurelw/azurehub/refs/heads/main/main.lua"))()

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local SelectedTargetName = nil 
_G.AutoTeleport = Settings.AutoTeleport or false
_G.SuperBypass = false

local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1.5
fovCircle.Color = Color3.fromRGB(220, 20, 20)
fovCircle.Filled = false
fovCircle.Visible = false

getgenv().SilentAim = {
    Enabled = Settings.SilentAim,
    FOV = Settings.SilentAim_FOV or 150,
    Prediction = Settings.SilentAim_Prediction or 100,
    Part = Settings.SilentAim_Part or "Head",
    HideFOV = Settings.SilentAim_HideFOV or false,
    InternalFOV = 1000
}

local Window = WindUI:CreateWindow({ Title = "ALEXX HUB", Icon = "apple" })
local MoveTab = Window:Tab({ Title = "Bypass Movimiento 🔓", Icon = "move" })

local function GetPlayerList()
    local list = {}
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= localPlayer then table.insert(list, v.Name) end
    end
    return #list > 0 and list or {"Esperando jugadores..."}
end

local PlayerDropdown = MoveTab:Dropdown({
    Title = "Seleccionar Jugador",
    List = GetPlayerList(),
    Callback = function(Option)
        SelectedTargetName = Option 
    end
})

MoveTab:Button({
    Title = "🔄 Refrescar Lista",
    Callback = function() PlayerDropdown:Refresh(GetPlayerList()) end
})

task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoTeleport and SelectedTargetName then
            local player = Players:FindFirstChild(SelectedTargetName)
            local char = player and player.Character
            local targetHRP = char and char:FindFirstChild("HumanoidRootPart")
            local myHRP = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if char and targetHRP and myHRP and char ~= LastTeleportedCharacter then
                myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 3)
                LastTeleportedCharacter = char
            end
        end
    end
end)

MoveTab:Toggle({
    Title = "Teletransport Player",
    Value = Settings.AutoTeleport,
    Callback = function(state)
        _G.AutoTeleport = state
        Settings.AutoTeleport = state
        Save()
    end
})

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

task.spawn(function() task.wait(2) PlayerDropdown:Refresh(GetPlayerList()) end)

local LocalPlayer = Players.LocalPlayer

local function isEnemy(player)
    if player == LocalPlayer then return false end
    local myTeam = LocalPlayer:GetAttribute("Team")
    local targetTeam = player:GetAttribute("Team")
    if myTeam and targetTeam then return myTeam ~= targetTeam end
    if LocalPlayer.Team and player.Team then return LocalPlayer.Team ~= player.Team end
    return false 
end

local HitboxTab = Window:Tab({ Title = "Combate ⚔️", Icon = "sword" })

getgenv().HitboxSize = 10 

HitboxTab:Slider({ Title = "Tamaño Hitbox", Value = { Min = 1, Max = 20, Default = 1 }, Callback = function(v) getgenv().HitboxSize = v end })

HitboxTab:Toggle({
    Title = "Activar Hitbox",
    Value = Settings.HitboxEnabled,
    Callback = function(state) 
        getgenv().HitboxEnabled = state 
        Settings.HitboxEnabled = state
        Save()
    end
})

HitboxTab:Toggle({
    Title = "Activar ESP",
    Value = Settings.EspEnabled,
    Callback = function(state) 
        getgenv().EspEnabled = state 
        Settings.EspEnabled = state
        Save()
    end
})

-- (Mantengo tus loops de hitbox y esp tal como estaban)
task.spawn(function()
    while true do
        task.wait(0.2)
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

-- Variable global de control
local AutoFarmActivo = false

HitboxTab:Toggle({
    Title = "Auto Farm 💰",
    Value = false,
    Callback = function(state)
        AutoFarmActivo = state
        
        if AutoFarmActivo then
            task.spawn(function()
                -- Definimos el contenedor fuera del bucle para mejor rendimiento
                local container = game:GetService("Workspace"):WaitForChild("SpawnablesClient")
                
                while AutoFarmActivo do
                    -- Iteramos sobre los hijos
                    for _, obj in pairs(container:GetChildren()) do
                        if AutoFarmActivo then
                            local touchPart = obj:FindFirstChild("Touch")
                            if touchPart then
                                -- Usamos la lógica de firetouchinterest que confirmaste
                                pcall(function()
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, touchPart, 0)
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, touchPart, 1)
                                end)
                            end
                        end
                    end
                    task.wait(0.5) -- Intervalo de medio segundo
                end
            end)
        end
    end
})
local HitboxProTab = Window:Tab({ Title = "Hitbox Disimulada🎯", Icon = "target" })

HitboxProTab:Slider({ Title = "Tamaño Hitbox Pro", Value = { Min = 1, Max = 20, Default = 1}, Callback = function(v) getgenv().HitboxSize2 = v end })

HitboxProTab:Toggle({
    Title = "Activar Hitbox Pro (Paredes)",
    Value = Settings.Hitbox2_Enabled,
    Callback = function(state) 
        getgenv().Hitbox2_Enabled = state 
        Settings.Hitbox2_Enabled = state
        Save()
    end
})

-- (Mantengo tu loop de Hitbox Pro)
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Hitbox2_Enabled then
            local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            for _, player in pairs(Players:GetPlayers()) do
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChild("Humanoid")
                if char and hum and hum.Health > 0 and hrp and isEnemy(player) then
                    local isVisible = true
                    if myHRP then
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {LocalPlayer.Character, workspace.CurrentCamera}
                        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                        local ray = workspace:Raycast(myHRP.Position, (hrp.Position - myHRP.Position), rayParams)
                        if ray and not ray.Instance:IsDescendantOf(char) then isVisible = false end
                    end
                    if isVisible then
                        hrp.Size = Vector3.new(getgenv().HitboxSize2, getgenv().HitboxSize2, getgenv().HitboxSize2)
                        hrp.Transparency = 0.5
                        hrp.Material = Enum.Material.Neon
                        hrp.Color = Color3.fromRGB(255, 0, 0)
                        hrp.CanCollide = false
                    else
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                end
            end
        end
    end
end)

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Función optimizada para obtener el objetivo (funciona en móvil y PC)
local function getClosest()
    local currentFOV = getgenv().SilentAim.HideFOV and getgenv().SilentAim.InternalFOV or getgenv().SilentAim.FOV
    local targetPart, targetPlayer, closest = nil, nil, currentFOV
    
    local viewportCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local part = p.Character:FindFirstChild(getgenv().SilentAim.Part)
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            
            if part and hrp and hum and hum.Health > 0 then
                -- Validación de visibilidad (Raycast)
                local ray = Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 500)
                local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
                
                if hit and hit:IsDescendantOf(p.Character) then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local mouseDist = (Vector2.new(screenPos.X, screenPos.Y) - viewportCenter).Magnitude
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

-- Hook para evitar el uso del Mouse.Hit y hacerlo compatible

if hookmetamethod then
    local oldIndex
    oldIndex = hookmetamethod(game, "__index", function(self, index)
        -- Solo interviene si:
        -- 1. No somos nosotros mismos (evita errores internos)
        -- 2. El SilentAim está prendido
        -- 3. Buscan "Hit" o "Target"
        -- 4. UserInputService detecta que estamos disparando (Mouse1 o Touch)
        
        local isShooting = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or 
                           UserInputService:IsMouseButtonPressed(Enum.UserInputType.Touch)

        if not checkcaller() and getgenv().SilentAim.Enabled and (index == "Hit" or index == "Target") and isShooting then
            local targetPart, targetPlayer = getClosest()
            
            if targetPart and targetPlayer and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local predFactor = getgenv().SilentAim.Prediction / 100 
                local velocity = targetPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity
                return CFrame.new(targetPart.Position + (velocity * 0.085 * predFactor))
            end
        end
        
        return oldIndex(self, index)
    end)
end

-- Asegúrate de inicializar fovCircle fuera del bucle para no crearlo cada vez
-- Si no lo tienes, añádelo antes de este bloque.

-- 1. FUNCIÓN CENTRALIZADA (Debe ir antes de los Toggles)
local function UpdateFOV()
    if fovCircle then
        local shouldShow = getgenv().SilentAim.Enabled and not getgenv().SilentAim.HideFOV
        fovCircle.Visible = shouldShow
    end
end

-- 2. RENDERSTEPPED OPTIMIZADO (Solo actualiza posición/radio si es visible)
RunService.RenderStepped:Connect(function()
    -- Solo actualizamos la posición si el círculo ya está visible
    if fovCircle and fovCircle.Visible then
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        fovCircle.Radius = getgenv().SilentAim.FOV
    end
end)


-- 3. INTERFAZ Y TOGGLES
local AimTab = Window:Tab({ Title = "Silent Aim 🎯", Icon = "crosshair" })

-- Toggle 1: Activar Silent Aim (Controla también el FOV)
AimTab:Toggle({
    Title = "Activar Silent Aim",
    Value = Settings.SilentAim,
    Callback = function(v) 
        getgenv().SilentAim.Enabled = v 
        Settings.SilentAim = v
        
        -- ESTA ES LA LÓGICA QUE FALTABA:
        -- Si activas el Silent, el círculo se muestra (siempre que no esté marcado como oculto)
        if fovCircle then
            fovCircle.Visible = v and not getgenv().SilentAim.HideFOV
        end
        
        Save()
    end
})

-- Toggle 2: Ocultar FOV Circle
AimTab:Toggle({
    Title = "Ocultar FOV Circle",
    Value = getgenv().SilentAim.HideFOV,
    Callback = function(v) 
        getgenv().SilentAim.HideFOV = v 
        
        -- Si desmarcas "Ocultar", el círculo solo aparece si el Silent Aim está prendido
        if fovCircle then
            fovCircle.Visible = getgenv().SilentAim.Enabled and not v
        end
    end
})

AimTab:Toggle({ Title = "Apuntar a Cabeza", Value = getgenv().SilentAim.Part == "Head", Callback = function(v) if v then getgenv().SilentAim.Part = "Head" end end })
AimTab:Toggle({ Title = "Apuntar a Torso", Value = getgenv().SilentAim.Part == "HumanoidRootPart", Callback = function(v) if v then getgenv().SilentAim.Part = "HumanoidRootPart" end end })

AimTab:Slider({ Title = "Radio FOV", Value = { Min = 30, Max = 1000, Default = 150 }, Callback = function(v) getgenv().SilentAim.FOV = v end })
AimTab:Slider({ Title = "Predicción", Value = { Min = 0, Max = 100, Default = 100 }, Callback = function(v) getgenv().SilentAim.Prediction = v end })

-- Resto de tabs (Players, External, etc.) se mantienen igual...
-- (Pega el resto de tu script desde "local runService = ..." hasta el final)

local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local noclip = false

runService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

local LocalTab = Window:Tab({ Title = "Players", Icon = "map" })

LocalTab:Toggle({ Title = "Atravesar Paredes", Value = false, Callback = function(state) noclip = state end })

_G.SpeedEnabled = Settings.SpeedEnabled
_G.SpeedMultiplier = 0

LocalTab:Toggle({
    Title = "Activar Speed",
    Value = Settings.SpeedEnabled,
    Callback = function(state)
        _G.SpeedEnabled = state
        Settings.SpeedEnabled = state
        Save()
    end
})

LocalTab:Slider({ Title = "Speed Slider", Value = { Min = 0, Max = 100, Default = 0 }, Callback = function(v) _G.SpeedMultiplier = v / 100 end })

RunService.RenderStepped:Connect(function()
    if _G.SpeedEnabled and _G.SpeedMultiplier > 0 then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp and hum and hum.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * _G.SpeedMultiplier)
        end
    end
end)

_G.InfiniteJump = Settings.InfiniteJump
LocalTab:Toggle({ Title = "Salto Infinito", Value = Settings.InfiniteJump, Callback = function(state) _G.InfiniteJump = state; Settings.InfiniteJump = state; Save() end })

UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

_G.FOVEnabled = Settings.FOVEnabled
local DefaultFOV = 70 
LocalTab:Toggle({
    Title = "Activar FOV",
    Value = Settings.FOVEnabled,
    Callback = function(state)
        _G.FOVEnabled = state
        Settings.FOVEnabled = state
        Save()
        if not state then Camera.FieldOfView = DefaultFOV end
    end
})

LocalTab:Slider({ Title = "Valor FOV", Value = { Min = 70, Max = 120, Default = 70 }, Callback = function(v) if _G.FOVEnabled then Camera.FieldOfView = v end end })

_G.WallClimb = Settings.WallClimb
LocalTab:Toggle({ Title = "Wall Climb", Value = Settings.WallClimb, Callback = function(state) _G.WallClimb = state; Settings.WallClimb = state; Save() end })

RunService.RenderStepped:Connect(function()
    if _G.WallClimb then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hum and hrp and hum.MoveDirection.Magnitude > 0 then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 25, hrp.Velocity.Z)
        end
    end
end)

local ExternalTab = Window:Tab({ Title = "External", Icon = "file-code" })

ExternalTab:Button({ Title = "Ejecutar Script(7yd7)", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024"))() end })
ExternalTab:Button({ Title = "Emotes Vexro", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Vexro-Emote-Player-40K-Emotes-Keyless-229963"))() end })


UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Z then Window:Toggle() end
end)