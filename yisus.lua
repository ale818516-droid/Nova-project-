local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {}
Library.__index = Library

local Window = {}
Window.__index = Window

local Tab = {}
Tab.__index = Tab

function Library:CreateWindow(Config)

	Config = Config or {}

	local WindowObject = setmetatable({}, Window)

WindowObject.Title = Config.Title or "Yisus Hub"
WindowObject.Size = Config.Size or UDim2.new(0,520,0,320)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YisusUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = WindowObject.Size
Main.Position = UDim2.new(0.5,0,0.5,0)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = Color3.fromRGB(20,25,30)
Main.BorderSizePixel = 0

local Corner = Instance.new("UICorner")
Corner.Parent = Main
Corner.CornerRadius = UDim.new(0,10)

local Stroke = Instance.new("UIStroke")
Stroke.Parent = Main
Stroke.Color = Color3.fromRGB(0,255,255)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,15,0,10)
Title.Size = UDim2.new(1,-30,0,30)

Title.Font = Enum.Font.GothamBold
Title.Text = WindowObject.Title
Title.TextColor3 = Color3.fromRGB(240,240,240)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

WindowObject.Gui = ScreenGui
WindowObject.Main = Main

return WindowObject

end

return Library


