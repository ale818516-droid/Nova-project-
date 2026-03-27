-- [[ PROYECTO NOVA: INFINITE v31.0 ]] --
-- MVS GLOBAL INSTA-KILL - BY NOVADEV --

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/source.lua"))()
local L = game.Players.LocalPlayer
local C = workspace.CurrentCamera

local Window = Fluent:CreateWindow({
    Title = "Nova Infinite - MVS - By NovaDev",
    SubTitle = "Global Insta-Kill",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460), Acrylic = true, Theme = "Dark"
})

local Tabs = { Main = Window:AddTab({ Title = "Global Combat", Icon = "globe" }) }

Tabs.Main:AddToggle("GlobalKill", {Title = "Global Insta-Kill (Cualquier lado)", Default = false})

-- --- EL MOTOR DE LA BALA MÁGICA ---
-- Busca al enemigo más cercano en 3D, sin importar si lo ves o no.

local function GetClosestGlobal()
    local Target = nil
    local MaxDist = math.huge -- Distancia infinita
    
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= L and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= L.Team then
            local dist = (L.Character.HumanoidRootPart.Position - p.Character.Head.Position).Magnitude
            if dist < MaxDist then
                Target = p.Character.Head
                MaxDist = dist
            end
        end
    end
    return Target
end

-- HOOKING TOTAL (Intercepción de Balas)
local OldIndex = nil
OldIndex = hookmetamethod(game, "__index", function(Self, Index)
    if not checkcaller() and Fluent.Options.GlobalKill.Value and Index == "Hit" then
        local Target = GetClosestGlobal()
        if Target then
            return Target.CFrame -- La bala se teletransporta a la cabeza
        end
    end
    return OldIndex(Self, Index)
end)

-- WALL-BANG BYPASS (Atravesar paredes)
local OldRaycast = nil
OldRaycast = hookfunction(workspace.Raycast, function(Self, Origin, Direction, Params)
    if not checkcaller() and Fluent.Options.GlobalKill.Value then
        local Target = GetClosestGlobal()
        if Target then
            -- Redirigir la trayectoria física a través de cualquier objeto
            Direction = (Target.Position - Origin).Unit * 5000
        end
    end
    return OldRaycast(Self, Origin, Direction, Params)
end)

Fluent:Notify({Title = "Nova Infinite", Content = "Modo Global Activado. Balas certeras en cualquier lado.", Duration = 8})
