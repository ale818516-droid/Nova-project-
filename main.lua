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

-- Variables de Estado del Hitbox Expander
local UIElements = {}
local hitboxEnabled = false
local hitboxInvisible = false
local hitboxSize = 10
local hitboxColor = Color3.fromRGB(255, 255, 255)

-- Función opcional de verificación de lobby/enemigos (por defecto retorna true si no existe una externa)
local function isEnemy(v)
    return true
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

task.spawn(function()
    if getgenv().AstraHitboxLoop then getgenv().AstraHitboxLoop = false task.wait(0.2) end
    getgenv().AstraHitboxLoop = true

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

    while getgenv().AstraHitboxLoop and task.wait(0.1) do
        local enLobby = false 
        pcall(function() enLobby = estaEnLobby() end)
        
        if hitboxEnabled and not enLobby then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= player and isEnemy(v) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                    local hrp = v.Character.HumanoidRootPart 
                    
                    -- Verificamos si está a la vista (fuera de la pared) mediante un Raycast
                    local aLaVista = false
                    if player.Character and player.Character:FindFirstChild("Head") then
                        local origin = camera.CFrame.Position 
                        params.FilterDescendantsInstances = {player.Character, v.Character}
                        local result = workspace:Raycast(origin, hrp.Position - origin, params) 
                        aLaVista = not result 
                    end
                    
                    -- Si está detrás de la pared (no visible), tamaño normal (2,2,1). Si sale, se agranda al tamaño configurado.
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
        else 
            for _, v in pairs(Players:GetPlayers()) do if v ~= player then limpiarHitbox(v) end end 
        end
    end
end)
