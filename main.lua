--[[
    Onyx HUD - DMVS Edition (Versión Compacta)
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local guiName = "OnyxHubDMVS_Compact"

-- Eliminar UI anterior si existe
if CoreGui:FindFirstChild(guiName) then
    CoreGui[guiName]:Destroy()
end

-- Configuración de colores
local Colors = {
    Accent = Color3.fromRGB(0, 255, 255), -- Cian Neón
    Background = Color3.fromRGB(20, 25, 30), -- Azul Oscuro Profundo
    PanelBg = Color3.fromRGB(30, 35, 40), -- Gris Azulado
    Text = Color3.fromRGB(240, 240, 240)
}

-- Función para arrastrar la ventana
local function makeDraggable(guiObject, dragObject)
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        dragObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = dragObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- --- CREACIÓN DE LA INTERFAZ ---

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Marco Principal (Tamaño reducido: 520 x 320)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.Size = UDim2.new(0, 520, 0, 320)
makeDraggable(MainFrame, MainFrame)

-- Borde de neón exterior
local GlowBorder = Instance.new("UIStroke")
GlowBorder.Parent = MainFrame
GlowBorder.Color = Colors.Accent
GlowBorder.Thickness = 2
GlowBorder.Transparency = 0.5

-- Esquinas redondeadas
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

-- Título
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 8)
TitleLabel.Size = UDim2.new(0, 250, 0, 25)
TitleLabel.Font = Enum.Font.GothamSemibold
TitleLabel.Text = "Onyx Hub | DMVS Edition"
TitleLabel.TextColor3 = Colors.Text
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Barra Lateral 
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Colors.PanelBg
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 10, 0, 40)
Sidebar.Size = UDim2.new(0, 50, 0, 270)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)

-- Área de Contenido Vacía
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 70, 0, 40)
ContentArea.Size = UDim2.new(0, 440, 0, 270)

print("Plantilla compacta cargada correctamente.")
