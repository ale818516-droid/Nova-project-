local WindUI
local version = "1.6.66"

WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/download/" .. version .. "/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = "ONYX HUB",
    Theme = "Dark",
    Author = "AlexDev",
    Folder = "OnyxHub",
    Acrylic = false,
    Transparent = false,
    NewElements = true,
    HideSearchBar = false,

    OpenButton = {
        Enabled = true,
        Draggable = true,
        Title = "Open",
        CornerRadius = UDim.new(1),
        Scale = 0.8
    },

    Topbar = {
        Height = 44,
        ButtonsType = "Default"
    }
})

WindUI:SetTheme("Dark")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

-- Variables de Estado
local UIElements = {}
local hitboxEnabled = false
local hitboxInvisible = false
local hitboxSize = 10
local hitboxColor = Color3.fromRGB(255, 255, 255)

local espEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)

-- ==========================================
-- FUNCIÓN isEnemy (Verificación de Equipos)
-- ==========================================
local LocalPlayer = Players.LocalPlayer

local function isEnemy(target)
    if target == LocalPlayer then
        return false
    end

    local myTeam = LocalPlayer:GetAttribute("Team")
    local targetTeam = target:GetAttribute("Team")

    if myTeam and targetTeam then
        return myTeam ~= targetTeam
    end

    if LocalPlayer.Team and target.Team then
        return LocalPlayer.Team ~= target.Team
    end

    return false
end

local function estaEnLobby()
    return false
end

-- Creación de la Pestaña Aim
local Tabs = {
    Aim = Window:Tab({
        Title = "Aim",
        Icon = "crosshair"
    })
}

-- ==========================================
-- HITBOX EXPANDER
-- ==========================================
Tabs.Aim:Section({Title = "Hitbox Expander"})

UIElements.TogHitbox = Tabs.Aim:Toggle({
    Title = "Aumentar Hitbox",
    Desc = "Expande la caja de colisión de los enemigos solo cuando están visibles (fuera de paredes).",
    Callback = function(s) 
        hitboxEnabled = s 
        if not s then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = v.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                    hrp.Material = Enum.Material.Plastic
                    hrp.CanCollide = true
                    local box = hrp:FindFirstChild("AstraHitboxBox")
                    if box then box:Destroy() end
                end
            end
        end
    end
})

UIElements.TogHbInv = Tabs.Aim:Toggle({
    Title = "Hitbox Invisible", 
    Desc = "Oculta las cajas gigantes de los enemigos.",
    Callback = function(s) hitboxInvisible = s end
})

UIElements.SliHitbox = Tabs.Aim:Slider({
    Title = "Tamaño de Hitbox (Slider)", 
    Step = 1,
    Value = {Min = 2, Max = 50, Default = 10}, 
    Callback = function(v) hitboxSize = v end
})

Tabs.Aim:Input({
    Title = "Escribir Tamaño Exacto",
    Placeholder = "Ej: 2, 12, 25...",
    Callback = function(Text)
        local num = tonumber(Text)
        if num then
            hitboxSize = num
            pcall(function() if num >= 2 and num <= 50 then UIElements.SliHitbox:Set(num) end end)
        end
    end,
})

UIElements.ColHitbox = Tabs.Aim:Colorpicker({
    Title = "Color de Hitbox", 
    Default = Color3.fromRGB(255,255,255), 
    Callback = function(c) hitboxColor = c end
})

-- ==========================================
-- ESP (HIGHLIGHT CONTORNO)
-- ==========================================
Tabs.Aim:Section({Title = "Visuales de Enemigos"})

UIElements.TogEsp = Tabs.Aim:Toggle({
    Title = "Activar ESP (Solo Contorno)",
    Desc = "Remarca la silueta del Humanoid a través de las paredes.",
    Callback = function(s) 
        espEnabled = s 
    end
})

UIElements.ColEsp = Tabs.Aim:Colorpicker({
    Title = "Color del ESP", 
    Default = Color3.fromRGB(255, 0, 0), 
    Callback = function(c) espColor = c end
})

-- ==========================================
-- BUCLE PRINCIPAL (HITBOX & ESP)
-- ==========================================
task.spawn(function()
    if getgenv().AstraLoopRunning then getgenv().AstraLoopRunning = false task.wait(0.2) end
    getgenv().AstraLoopRunning = true

    local function limpiarHitbox(v)
        if v and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = v.Character.HumanoidRootPart
            hrp.Size = Vector3.new(2, 2, 1) 
            hrp.Transparency = 1 
            hrp.Material = Enum.Material.Plastic 
            hrp.CanCollide = true
            local box = hrp:FindFirstChild("AstraHitboxBox") 
            if box then box:Destroy() end
        end
    end

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude

    while getgenv().AstraLoopRunning and task.wait(0.1) do
        local enLobby = false 
        pcall(function() enLobby = estaEnLobby() end)
        
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player then
                local char = v.Character
                local esEnemigoValido = isEnemy(v) and char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0

                -- 1. LÓGICA DEL ESP
                if espEnabled and esEnemigoValido and not enLobby then
                    local hl = char:FindFirstChild("OnyxESP")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "OnyxESP"
                        hl.FillTransparency = 1 -- 1 = Transparente (No rellena el cuerpo)
                        hl.OutlineTransparency = 0 -- 0 = Visible (Solo el contorno)
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = char
                    end
                    hl.OutlineColor = espColor
                else
                    if char and char:FindFirstChild("OnyxESP") then
                        char.OnyxESP:Destroy()
                    end
                end

                -- 2. LÓGICA DE LA HITBOX
                if hitboxEnabled and esEnemigoValido and not enLobby and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart 
                    
                    local aLaVista = false
                    if player.Character and player.Character:FindFirstChild("Head") then
                        local origin = camera.CFrame.Position 
                        params.FilterDescendantsInstances = {player.Character, char}
                        local result = workspace:Raycast(origin, hrp.Position - origin, params) 
                        aLaVista = not result 
                    end
                    
                    local targetSize = aLaVista and Vector3.new(hitboxSize, hitboxSize, hitboxSize) or Vector3.new(2, 2, 1)
                    
                    if hrp.Size ~= targetSize then hrp.Size = targetSize end
                    if hrp.CanCollide ~= false then hrp.CanCollide = false end
                    
                    local targetColor = aLaVista and hitboxColor or Color3.fromRGB(255, 50, 50)
                    local targetTrans = (hitboxInvisible or not aLaVista) and 1 or 0.4
                    
                    if hrp.Transparency ~= targetTrans then hrp.Transparency = targetTrans end
                    if hrp.Material ~= Enum.Material.ForceField then hrp.Material = Enum.Material.ForceField end
                    if hrp.Color ~= targetColor then hrp.Color = targetColor end
                    
                    local box = hrp:FindFirstChild("AstraHitboxBox")
                    if not aLaVista then
                        if box then box:Destroy() end
                    else
                        if not box then 
                            box = Instance.new("BoxHandleAdornment") 
                            box.Name = "AstraHitboxBox" 
                            box.Adornee = hrp 
                            box.AlwaysOnTop = true 
                            box.ZIndex = 5 
                            box.Parent = hrp 
                        end
                        
                        if box.Size ~= hrp.Size then box.Size = hrp.Size end
                        if box.Color3 ~= targetColor then box.Color3 = targetColor end
                        
                        local targetBoxTrans = hitboxInvisible and 1 or 0.2
                        if box.Transparency ~= targetBoxTrans then box.Transparency = targetBoxTrans end
                        if box.Visible ~= not hitboxInvisible then box.Visible = not hitboxInvisible end
                    end
                else 
                    limpiarHitbox(v) 
                end
            end
        end
    end
end)

-- ==========================================
-- MÓDULO FINAL: MACRO DE PISTOLA + ZONA MUERTA (FUNCIONAL Y ESTABLE)
-- ==========================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Asegurar contenedor visual
local screenGui = player:FindFirstChild("PlayerGui"):FindFirstChild("AstraScreenGui")
if not screenGui then
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AstraScreenGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

-- Función de arrastre táctil/mouse segura
local function makeDraggableSafe(frame, handle)
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- 1. CREACIÓN DE LA ZONA MUERTA (FRAME VISUAL)
local deadZoneFrame = Instance.new("Frame")
deadZoneFrame.Size = UDim2.new(0, 150, 0, 150)
deadZoneFrame.Position = UDim2.new(0.8, -75, 0.8, -75) 
deadZoneFrame.BackgroundColor3 = Color3.fromRGB(255, 50, 50) 
deadZoneFrame.BackgroundTransparency = 0.5
deadZoneFrame.Visible = false
deadZoneFrame.ZIndex = 100
deadZoneFrame.Parent = screenGui 
Instance.new("UICorner", deadZoneFrame).CornerRadius = UDim.new(0, 16)

local dzStroke = Instance.new("UIStroke", deadZoneFrame)
dzStroke.Color = Color3.fromRGB(255, 255, 255)
dzStroke.Thickness = 2
dzStroke.LineJoinMode = Enum.LineJoinMode.Round

local dzLabel = Instance.new("TextLabel", deadZoneFrame)
dzLabel.Size = UDim2.new(1, 0, 1, 0)
dzLabel.BackgroundTransparency = 1
dzLabel.Text = "ZONA MUERTA\n(Arrastrar)"
dzLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
dzLabel.Font = Enum.Font.GothamBold
dzLabel.TextSize = 14
dzLabel.TextWrapped = true

makeDraggableSafe(deadZoneFrame, deadZoneFrame)

-- 2. LÓGICA DE DETECCIÓN DE ARMAS Y DAÑO
getgenv().AutoEquipEnabled = false
local startPos = Vector2.new(0, 0)
local startTime = 0 
local CLICK_THRESHOLD = 20 

local function buscarArma()
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    local arma = nil
    
    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") and item:FindFirstChild("fire") then
                arma = item
                break
            end
        end
    end
    
    if not arma and char then
        for _, item in pairs(char:GetChildren()) do
            if item:IsA("Tool") and item:FindFirstChild("fire") then
                arma = item
                break
            end
        end
    end
    
    return arma
end

local function ejecutarAccionMacro()
    local char = player.Character
    if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then return end
    local backpack = player:FindFirstChild("Backpack")
    local arma = buscarArma()
    
    if arma then
        task.spawn(function()
            char.Humanoid:EquipTool(arma)
            task.wait(0.05)
            arma:Activate()
            task.wait(0.12)
            if arma.Parent == char and backpack then
                arma.Parent = backpack
            end
        end)
    end
end

-- 3. INTERACCIÓN TÁCTIL Y DE TOQUES (EXCLUYENDO LA ZONA MUERTA)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not getgenv().AutoEquipEnabled or gameProcessed then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        ejecutarAccionMacro()
    elseif input.UserInputType == Enum.UserInputType.Touch then
        startPos = input.Position
        startTime = tick() 
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not getgenv().AutoEquipEnabled or gameProcessed or input.UserInputType ~= Enum.UserInputType.Touch then return end
    
    local pos = input.Position
    local dzPos = deadZoneFrame.AbsolutePosition
    local dzSize = deadZoneFrame.AbsoluteSize
    local tocoZonaMuerta = (pos.X >= dzPos.X) and (pos.X <= dzPos.X + dzSize.X) and (pos.Y >= dzPos.Y) and (pos.Y <= dzPos.Y + dzSize.Y)
    
    if tocoZonaMuerta then return end
    
    if (input.Position - startPos).Magnitude < CLICK_THRESHOLD and (tick() - startTime) < 0.25 then
        ejecutarAccionMacro()
    end
end)

-- 4. CONTROLES DE INTERFAZ (UI) PARA CONECTAR A TU MENÚ (WINDUI)
local AimTab = Window:Tab({ Title = "Aimbot", Icon = "target" })
AimTab:Section({Title = "Macro (Pistola)"})

AimTab:Toggle({
    Title = "Activar Macro", 
    Desc = "Dispara con un solo toque.",
    Value = false,
    Callback = function(state) 
        getgenv().AutoEquipEnabled = state 
    end
})

AimTab:Toggle({
    Title = "Mostrar/Acomodar Zona Muerta", 
    Value = false,
    Callback = function(s) deadZoneFrame.Visible = s end
})

AimTab:Slider({
    Title = "Tamaño de Zona Muerta", 
    Step = 10,
    Value = {Min = 80, Max = 400, Default = 150}, 
    Callback = function(v) deadZoneFrame.Size = UDim2.new(0, v, 0, v) end
})
