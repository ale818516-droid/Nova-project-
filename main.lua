-- [[ PROYECTO NOVA: v25.0 MVS SPECIAL ]] --
local P = game:GetService("Players")
local R = game:GetService("RunService")
local L = P.LocalPlayer
local C = workspace.CurrentCamera

_G.NovaActivo = false

-- Interfaz minimalista para evitar borrado
local G = Instance.new("ScreenGui", L:WaitForChild("PlayerGui"))
G.Name = "MVS_Nova"
local B = Instance.new("TextButton", G)
B.Size, B.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0.05, 0, 0.3, 0)
B.Text, B.BackgroundColor3 = "NOVA", Color3.fromRGB(255, 0, 0)
B.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", B)
B.Draggable = true

-- Activar/Desactivar todo con un clic
B.MouseButton1Click:Connect(function()
    _G.NovaActivo = not _G.NovaActivo
    B.BackgroundColor3 = _G.NovaActivo and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    B.Text = _G.NovaActivo and "ON" or "OFF"
end)

-- Función de combate para MVS
R.RenderStepped:Connect(function()
    if not _G.NovaActivo then return end

    -- Speed Bypass para MVS
    if L.Character and L.Character:FindFirstChild("Humanoid") then
        L.Character.Humanoid.WalkSpeed = 22 -- Velocidad segura para no ser kickeado
    end

    for _, p in pairs(P:GetPlayers()) do
        if p ~= L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local root = p.Character.HumanoidRootPart
            local head = p.Character:FindFirstChild("Head")

            -- ESP (Círculos en los pies para que no lo borre el anticheat)
            if not root:FindFirstChild("MVS_ESP") then
                local e = Instance.new("Highlight", root)
                e.Name = "MVS_ESP"
                e.FillColor = Color3.fromRGB(255, 0, 0)
                e.OutlineColor = Color3.fromRGB(255, 255, 255)
                e.FillTransparency = 0.5
            end

            -- AUTO COMBAT (Detecta si eres Sheriff o Asesino)
            if head then
                local _, visible = C:WorldToViewportPoint(head.Position)
                if visible then
                    local dist = (L.Character.HumanoidRootPart.Position - root.Position).Magnitude
                    
                    -- Si tienes arma y están en rango
                    local tool = L.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        -- Apuntado asistido
                        C.CFrame = C.CFrame:Lerp(CFrame.new(C.CFrame.Position, head.Position), 0.2)
                        
                        -- Disparo/Ataque Automático
                        if dist < 250 then
                            tool:Activate()
                        end
                    end
                end
            end
        end
    end
end)
