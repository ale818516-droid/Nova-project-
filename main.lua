-- [[ PROYECTO NOVA: v32.0 MAGNETIC LOCK ]] --
-- FUERZA BRUTA PARA MVS - BY NOVADEV --

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/source.lua"))()
local L = game.Players.LocalPlayer
local C = workspace.CurrentCamera
local R = game:GetService("RunService")

local Window = Fluent:CreateWindow({
    Title = "Nova Magnetic - MVS - By NovaDev",
    SubTitle = "Lock-On Edition",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"
})

local Tabs = { Main = Window:AddTab({ Title = "Combat", Icon = "zap" }) }

local LockOn = Tabs.Main:AddToggle("LockOn", {Title = "Imán de Cabezas (Magnetic)", Default = false})

-- --- EL MOTOR MAGNÉTICO ---
-- Esta función busca al enemigo y PEGA tu cámara a su cabeza
local function GetTarget()
    local Target = nil
    local shortestDistance = math.huge

    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= L and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= L.Team then
            local dist = (L.Character.HumanoidRootPart.Position - p.Character.Head.Position).Magnitude
            if dist < shortestDistance then
                Target = p.Character.Head
                shortestDistance = dist
            end
        end
    end
    return Target
end

-- EJECUCIÓN FORZADA (RenderStepped es el más rápido)
R.RenderStepped:Connect(function()
    if LockOn.Value then
        local Tar = GetTarget()
        if Tar then
            -- FUERZA MÁXIMA: La cámara se clava en la cabeza
            C.CFrame = CFrame.new(C.CFrame.Position, Tar.Position)
            
            -- DISPARO AUTOMÁTICO
            local tool = L.Character:FindFirstChildOfClass("Tool")
            if tool then 
                tool:Activate() 
            end
        end
    end
end)

Fluent:Notify({Title = "Nova Magnetic", Content = "Imán de cabezas activado. Saca tu arma.", Duration = 5})
