-- [[ PROYECTO NOVA: ELITE v28.0 - BY NOVADEV ]] --
-- RÉPLICA PROFESIONAL ESTILO FASTDEX --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local L = game.Players.LocalPlayer
local C = workspace.CurrentCamera
local R = game:GetService("RunService")

-- 1. CREAR TU VENTANA (Personalizada con tu nombre)
local Window = Fluent:CreateWindow({
    Title = "Nova - MVS Elite v28.0 - By NovaDev",
    SubTitle = "FastDex Style Replica",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- Efecto borroso de fondo (Como en la foto)
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightShift -- Pulsa Shift Derecho para ocultar
})

-- Variables de Estado
_G.NovaESP = false
_G.NovaAim = false
_G.AimStrength = 70 -- Valor por defecto (70%)

-- 2. PESTAÑAS ( Tabs )
local Tabs = {
    Main = Window:AddTab({ Title = "AimAssist", Icon = "target" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- --- PESTAÑA PRINCIPAL (AimAssist) ---
-- Esta es la réplica exacta de la interfaz de la foto

Tabs.Main:AddToggle("AimShot", {Title = "Auto Shoot", Default = false})

Tabs.Main:AddSlider("AimStrength", {
    Title = "Aim Assist Strength",
    Description = "Ajusta la fuerza del auto-apuntado (70% recomendado)",
    Default = 70,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        _G.AimStrength = Value
    end
})

-- --- PESTAÑA DE VISUALES (Visuals) ---

Tabs.Visuals:AddToggle("ESPPor", {
    Title = "ESP Pro", 
    Default = false,
    Callback = function(Value)
        _G.NovaESP = Value
    end
})

-- 3. MOTOR DE EJECUCIÓN (Lógica de MVS)
R.RenderStepped:Connect(function()
    if Options.AimShot.Value or _G.NovaESP then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local root = p.Character.HumanoidRootPart
                
                -- ESP Professional (BoxHandle: Lo más cercano a la foto)
                if _G.NovaESP and p.Team ~= L.Team then
                    if not root:FindFirstChild("NBox") then
                        local b = Instance.new("BoxHandleAdornment", root)
                        b.Name, b.AlwaysOnTop, b.Adornee, b.ZIndex = "NBox", true, root, 10
                        b.Size, b.Color3, b.Transparency = Vector3.new(4, 6, 1), Color3.fromRGB(255, 0, 0), 0.6
                    end
                elseif root:FindFirstChild("NBox") then root.NBox:Destroy() end

                -- AUTO SHOT (Fuerza del Slider - 70% por defecto)
                if Options.AimShot.Value and p.Team ~= L.Team then
                    local head = p.Character:FindFirstChild("Head")
                    if head then
                        local _, vis = C:WorldToViewportPoint(head.Position)
                        if vis then
                            -- Apuntado Smooth (Suave pero Efectivo)
                            local strength = (_G.AimStrength or 70) / 100
                            C.CFrame = C.CFrame:Lerp(CFrame.new(C.CFrame.Position, head.Position), strength)
                            
                            -- Activar Arma (Pistola o Cuchillo)
                            local tool = L.Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
            end
        end
    end
end)

Fluent:Notify({
    Title = "Proyecto Nova v28.0",
    Content = "Iniciado con éxito. Estilo Fluent activado.",
    Duration = 8
})
