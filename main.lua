-- MENÚ ULTRA LITE PARA IPHONE 14 (ALEXX HUB VIP)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")

-- Configuración del Menú
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "NovaMenu"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -50)
MainFrame.Size = UDim2.new(0, 150, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = true -- Para que puedas moverlo en la pantalla

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "ALEXX HUB VIP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- BOTÓN DE AUTO FARM
FarmButton.Parent = MainFrame
FarmButton.Position = UDim2.new(0.1, 0, 0.4, 0)
FarmButton.Size = UDim2.new(0.8, 0, 0, 40)
FarmButton.Text = "AUTO FARM: OFF"
FarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

local farming = false
FarmButton.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        FarmButton.Text = "AUTO FARM: ON"
        FarmButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        spawn(function()
            while farming do
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if farming and (obj.Name:lower():find("skull") or obj.Name:lower():find("calavera")) then
                        -- Recolección Remota (Sin moverse)
                        if obj:IsA("BasePart") then
                           firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                           firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                        end
                        local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then fireproximityprompt(prompt) end
                    end
                end
                task.wait(0.5)
            end
        end)
    else
        FarmButton.Text = "AUTO FARM: OFF"
        FarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
end)
