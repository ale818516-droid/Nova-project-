--Puedes hacer esto como una librería completa coml la de WinDui

--[[
    Onyx Library - Versión Estable y Centrada
]]

local Library = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local Colors = {
    Accent = Color3.fromRGB(0, 255, 255),
    Background = Color3.fromRGB(20, 25, 30),
    PanelBg = Color3.fromRGB(30, 35, 40),
    Text = Color3.fromRGB(240, 240, 240),
    CloseRed = Color3.fromRGB(255, 90, 90)
}

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

function Library:CreateWindow(windowName)
    local guiName = "OnyxLibrary_" .. math.random(1000, 9999)

    if PlayerGui:FindFirstChild(guiName) then
        PlayerGui[guiName]:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = guiName
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Marco Principal
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
    MainFrame.Visible = true

    makeDraggable(MainFrame, MainFrame)

    local GlowBorder = Instance.new("UIStroke")
    GlowBorder.Parent = MainFrame
    GlowBorder.Color = Colors.Accent
    GlowBorder.Thickness = 2
    GlowBorder.Transparency = 0.5

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 15, 0, 10)
    TitleLabel.Size = UDim2.new(0, 200, 0, 25)
    TitleLabel.Font = Enum.Font.GothamSemibold
    TitleLabel.Text = windowName or "Onyx Library"
    TitleLabel.TextColor3 = Colors.Text
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Botón Cerrar [X]
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = MainFrame
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.AnchorPoint = Vector2.new(1, 0)
    CloseButton.Position = UDim2.new(1, -8, 0, 8)
    CloseButton.BackgroundTransparency = 1
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

    -- Botón Minimizar [-]
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = MainFrame
    MinimizeButton.AnchorPoint = Vector2.new(1, 0)
    MinimizeButton.Position = UDim2.new(1, -35, 0, 8)
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Colors.Text
    MinimizeButton.TextSize = 16
    MinimizeButton.ZIndex = 999

    -- Barra Lateral
    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Color3.fromRGB(18,22,28)
    Sidebar.BorderSizePixel = 0
    Sidebar.Position = UDim2.new(0, 10, 0, 45)
    Sidebar.Size = UDim2.new(0, 58, 0, 265)

    local SideCorner = Instance.new("UICorner", Sidebar)
    SideCorner.CornerRadius = UDim.new(0,10)

    local SideStroke = Instance.new("UIStroke", Sidebar)
    SideStroke.Color = Colors.Accent
    SideStroke.Thickness = 1.5
    SideStroke.Transparency = 0.45

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Parent = Sidebar
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(1,0,1,-10)
    TabContainer.Position = UDim2.new(0,0,0,5)
    TabContainer.CanvasSize = UDim2.new(0,0,0,0)
    TabContainer.ScrollBarThickness = 0

    local TabLayout = Instance.new("UIListLayout", TabContainer)
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabLayout.Padding = UDim.new(0,8)
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Contenedor de Páginas
    local PagesContainer = Instance.new("Folder")
    PagesContainer.Name = "PagesContainer"
    PagesContainer.Parent = MainFrame

    -- BOTÓN FLOTANTE DE APERTURA
    local OpenButton = Instance.new("TextButton")
    OpenButton.Parent = ScreenGui
    OpenButton.BackgroundColor3 = Colors.Background
    OpenButton.BackgroundTransparency = 0.25
    OpenButton.AnchorPoint = Vector2.new(0.5, 0)
    OpenButton.Position = UDim2.new(0.5, 0, 0, 12) 
    OpenButton.Size = UDim2.new(0, 110, 0, 38)
    OpenButton.AutoButtonColor = false
    OpenButton.Text = ""
    OpenButton.ZIndex = 10

    local OpenCorner = Instance.new("UICorner", OpenButton)
    OpenCorner.CornerRadius = UDim.new(1, 0)

    local OpenStroke = Instance.new("UIStroke", OpenButton)
    OpenStroke.Color = Colors.Accent
    OpenStroke.Thickness = 1.5
    OpenStroke.Transparency = 0.4

    local StatusDot = Instance.new("Frame", OpenButton)
    StatusDot.BackgroundColor3 = Colors.Accent
    StatusDot.Position = UDim2.new(0, 14, 0.5, -4)
    StatusDot.Size = UDim2.new(0, 8, 0, 8)
    Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

    local ButtonText = Instance.new("TextLabel", OpenButton)
    ButtonText.BackgroundTransparency = 1
    ButtonText.Position = UDim2.new(0, 30, 0, 0)
    ButtonText.Size = UDim2.new(1, -30, 1, 0)
    ButtonText.Font = Enum.Font.GothamBold
    ButtonText.Text = windowName or "Onyx Hub"
    ButtonText.TextColor3 = Colors.Text
    ButtonText.TextSize = 12
    ButtonText.TextXAlignment = Enum.TextXAlignment.Left

    -- Lógica de Apertura y Cierre
    local isOpen = true
    local isAnimating = false

    local function toggleMenu()
        if isAnimating then return end
        isAnimating = true

        if isOpen then
            local tween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 520, 0, 0), BackgroundTransparency = 1})
            tween:Play()
            tween.Completed:Wait()
            MainFrame.Visible = false
        else
            MainFrame.Visible = true
            local tween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 520, 0, 320), BackgroundTransparency = 0.1})
            tween:Play()
            tween.Completed:Wait()
        end

        isOpen = not isOpen
        StatusDot.BackgroundColor3 = isOpen and Colors.Accent or Color3.fromRGB(80,80,80)
        isAnimating = false
    end

    OpenButton.MouseButton1Click:Connect(toggleMenu)
    MinimizeButton.MouseButton1Click:Connect(toggleMenu)

    -- Objeto Ventana
    local Window = {}
    local firstTab = true

    function Window:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Colors.PanelBg
        TabButton.BackgroundTransparency = 0.5
        TabButton.Size = UDim2.new(0, 48, 0, 32)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Text = name
        TabButton.TextColor3 = Colors.Text
        TabButton.TextSize = 9

        local TabCorner = Instance.new("UICorner", TabButton)
        TabCorner.CornerRadius = UDim.new(0, 6)

        local Page = Instance.new("ScrollingFrame")
        Page.Parent = PagesContainer
        Page.BackgroundTransparency = 1
        Page.Position = UDim2.new(0, 78, 0, 45)
        Page.Size = UDim2.new(0, 432, 0, 265)
        Page.CanvasSize = UDim2.new(0,0,0,0)
        Page.ScrollBarThickness = 3
        Page.Visible = false

        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        PageLayout.Padding = UDim.new(0, 6)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)

        if firstTab then
            Page.Visible = true
            TabButton.BackgroundColor3 = Colors.Accent
            TabButton.BackgroundTransparency = 0
            TabButton.TextColor3 = Color3.fromRGB(20, 25, 30)
            firstTab = false
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, p in pairs(PagesContainer:GetChildren()) do
                p.Visible = false
            end
            for _, b in pairs(TabContainer:GetChildren()) do
                if b:IsA("TextButton") then
                    b.BackgroundColor3 = Colors.PanelBg
                    b.BackgroundTransparency = 0.5
                    b.TextColor3 = Colors.Text
                end
            end
            Page.Visible = true
            TabButton.BackgroundColor3 = Colors.Accent
            TabButton.BackgroundTransparency = 0
            TabButton.TextColor3 = Color3.fromRGB(20, 25, 30)
        end)

        local TabSection = {}

        function TabSection:CreateButton(btnText, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = Page
            Button.BackgroundColor3 = Colors.PanelBg
            Button.Size = UDim2.new(0, 420, 0, 32)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.GothamSemibold
            Button.Text = "  " .. btnText
            Button.TextColor3 = Colors.Text
            Button.TextSize = 12
            Button.TextXAlignment = Enum.TextXAlignment.Left

            local CornerBtn = Instance.new("UICorner", Button)
            CornerBtn.CornerRadius = UDim.new(0, 6)

            Button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)

            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 45, 52)}):Play()
            end)
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Colors.PanelBg}):Play()
            end)
        end
       
       
        return TabSection
    end

    return Window
end
 return Library