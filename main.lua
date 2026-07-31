--[[
    Onyx HUD - DMVS Edition (Versión Definitiva y Estable)
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local guiName = "YisusHubDMVS_Compact"

-- Eliminar UI anterior si existe
if CoreGui:FindFirstChild(guiName) then
    CoreGui[guiName]:Destroy()
end

-- Configuración de colores
local Colors = {
    Accent = Color3.fromRGB(0, 255, 255), -- Cian Neón
    Background = Color3.fromRGB(20, 25, 30), -- Azul Oscuro Profundo
    PanelBg = Color3.fromRGB(30, 35, 40), -- Gris Azulado
    Text = Color3.fromRGB(240, 240, 240),
    CloseRed = Color3.fromRGB(255, 90, 90) -- Rojo para la X
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

-- Marco Principal (Tamaño: 520 x 320)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.ClipsDescendants = true

makeDraggable(MainFrame, MainFrame)

-- Borde de neón exterior
local GlowBorder = Instance.new("UIStroke")
GlowBorder.Name = "GlowBorder"
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
TitleLabel.Position = UDim2.new(0, 15, 0, 10)
TitleLabel.Size = UDim2.new(0, 200, 0, 25)
TitleLabel.Font = Enum.Font.GothamSemibold
TitleLabel.Text = "Yisus Hub"
TitleLabel.TextColor3 = Colors.Text
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ==========================================
-- BOTONES DE LA VENTANA (X y -)
-- ==========================================

-- Botón de Cerrar por completo [X]
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.TextSize = 14
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Position = UDim2.new(1, -8, 0, 8)
CloseButton.BackgroundTransparency = 1
CloseButton.BorderSizePixel = 0

CloseButton.Text = "x"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.TextColor3 = Color3.fromRGB(220,240,255)

CloseButton.ZIndex = 999

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {TextColor3 = Colors.CloseRed}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {TextColor3 = Colors.Text}):Play()
end)

-- Botón de Minimizar [-] 
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame

MinimizeButton.AnchorPoint = Vector2.new(1, 0)
MinimizeButton.Position = UDim2.new(1, -35, 0, 8)

MinimizeButton.Size = UDim2.new(0, 20, 0, 20)

MinimizeButton.BackgroundTransparency = 1
MinimizeButton.BorderSizePixel = 0

MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Colors.Text
MinimizeButton.TextSize = 16

MinimizeButton.ZIndex = 999

-- ==========================================

-- Barra Lateral 
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(18,22,28)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 10, 0, 45)
Sidebar.Size = UDim2.new(0, 58, 0, 265)

local SideCorner = Instance.new("UICorner")
SideCorner.Parent = Sidebar
SideCorner.CornerRadius = UDim.new(0,10)

local SideStroke = Instance.new("UIStroke")
SideStroke.Parent = Sidebar
SideStroke.Color = Colors.Accent
SideStroke.Thickness = 1.5
SideStroke.Transparency = 0.45

local SideGlow = Instance.new("UIStroke")
SideGlow.Parent = Sidebar
SideGlow.Color = Colors.Accent
SideGlow.Thickness = 5
SideGlow.Transparency = 0.82

-- Área de Contenido Vacía
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 70, 0, 45)
ContentArea.Size = UDim2.new(0, 440, 0, 265)

-- ==========================================
-- BOTÓN DE APERTURA SUPERIOR ("Floating Crystal Pill")
-- ==========================================

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "YisusToggleBtn"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Colors.Background
OpenButton.BackgroundTransparency = 0.25
OpenButton.Position = UDim2.new(0, 310, 0, 12) 
OpenButton.Size = UDim2.new(0, 110, 0, 38)
OpenButton.AutoButtonColor = false
OpenButton.Text = ""
OpenButton.ZIndex = 10 

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Parent = OpenButton
OpenStroke.Color = Colors.Accent
OpenStroke.Thickness = 1.5
OpenStroke.Transparency = 0.4

local GlowStroke = Instance.new("UIStroke")
GlowStroke.Parent = OpenButton
GlowStroke.Color = Color3.fromRGB(150,255,255)
GlowStroke.Thickness = 5
GlowStroke.Transparency = 0.75
GlowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local StatusDot = Instance.new("Frame")
StatusDot.Name = "StatusDot"
StatusDot.Parent = OpenButton
StatusDot.BackgroundColor3 = Colors.Accent
StatusDot.Position = UDim2.new(0, 14, 0.5, -4)
StatusDot.Size = UDim2.new(0, 8, 0, 8)
Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

local DotGlow = Instance.new("UIStroke")
DotGlow.Parent = StatusDot
DotGlow.Color = Colors.Accent
DotGlow.Thickness = 2
DotGlow.Transparency = 0.2

local ButtonText = Instance.new("TextLabel")
ButtonText.Parent = OpenButton
ButtonText.BackgroundTransparency = 1
ButtonText.Position = UDim2.new(0, 30, 0, 0)
ButtonText.Size = UDim2.new(1, -30, 1, 0)
ButtonText.Font = Enum.Font.GothamBold
ButtonText.Text = "Yisus Hub"
ButtonText.TextColor3 = Colors.Text
ButtonText.TextSize = 12
ButtonText.TextXAlignment = Enum.TextXAlignment.Left

OpenButton.MouseEnter:Connect(function()
    TweenService:Create(OpenButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(OpenStroke, TweenInfo.new(0.2), {Transparency = 0.1}):Play()
end)

OpenButton.MouseLeave:Connect(function()
    TweenService:Create(OpenButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.25}):Play()
    TweenService:Create(OpenStroke, TweenInfo.new(0.2), {Transparency = 0.4}):Play()
end)

-- Lógica limpia de minimizar y abrir (oculta o muestra el marco por completo al instante pero con total estabilidad)
local isOpen = true
local isAnimating = false

local function toggleMenu()
	if isAnimating then return end
	isAnimating = true

	if isOpen then
		local tween = TweenService:Create(
			MainFrame,
			TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{
				Size = UDim2.new(0, 520, 0, 0),
				BackgroundTransparency = 1
			}
		)

		tween:Play()
		tween.Completed:Wait()

		MainFrame.Visible = false
	else
		MainFrame.Visible = true
		MainFrame.Size = UDim2.new(0, 520, 0, 0)
		MainFrame.BackgroundTransparency = 1

		local tween = TweenService:Create(
			MainFrame,
			TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{
				Size = UDim2.new(0, 520, 0, 320),
				BackgroundTransparency = 0.1
			}
		)

		tween:Play()
		tween.Completed:Wait()
	end

	isOpen = not isOpen

if isOpen then
	TweenService:Create(StatusDot, TweenInfo.new(0.2), {
		BackgroundColor3 = Colors.Accent
	}):Play()

	TweenService:Create(DotGlow, TweenInfo.new(0.2), {
		Transparency = 0.2
	}):Play()

	TweenService:Create(GlowStroke, TweenInfo.new(0.2), {
		Transparency = 0.75
	}):Play()
else
	TweenService:Create(StatusDot, TweenInfo.new(0.2), {
		BackgroundColor3 = Color3.fromRGB(80,80,80)
	}):Play()

	TweenService:Create(DotGlow, TweenInfo.new(0.2), {
		Transparency = 1
	}):Play()

	TweenService:Create(GlowStroke, TweenInfo.new(0.2), {
		Transparency = 1
	}):Play()
end

isAnimating = false

end

OpenButton.MouseButton1Click:Connect(toggleMenu)
MinimizeButton.MouseButton1Click:Connect(toggleMenu)

print("YisusHub listo y funcionando perfectamente.")
