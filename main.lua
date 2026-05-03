--[[
    PROYECTO NOVA - ALEXX HUB VIP
    Corrección Final: Espía con Validación de Usuario Real
]]

-- Limpieza de interfaces previas
for _, v in pairs(game.CoreGui:GetChildren()) do
    if v:IsA("ScreenGui") and (v.Name:find("Rayfield") or v:FindFirstChild("Main")) then
        v:Destroy()
    end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ALEXX HUB VIP",
   LoadingTitle = "Proyecto Nova",
   LoadingSubtitle = "Seguridad 2026",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true, 
   KeySettings = {
      Title = "🔑 SISTEMA DE ACCESO",
      Subtitle = "Contraseña Requerida",
      Note = "Consigue el acceso en el canal oficial", 
      FileName = "NovaKey_Final_2026", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Yisuhub2006-@"} 
   }
})

-- 1. PESTAÑA: ESPÍA 👁️ (SOLO JUGADORES REALES)
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
_G.EspActive = false

SpyTab:CreateToggle({
   Name = "Activar Marcado Rojo",
   CurrentValue = false,
   Callback = function(Value)
      _G.EspActive = Value
      if _G.EspActive then
         task.spawn(function()
            while _G.EspActive do
               for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                  -- VALIDACIÓN: Solo marca si es un jugador real, no es el usuario local y tiene personaje
                  if p ~= game.Players.LocalPlayer and p.Character and p:IsA("Player") then
                     local char = p.Character
                     if not char:FindFirstChild("NovaESP") then
                        -- El resaltado solo se aplica al modelo que el servidor reconoce como jugador
                        local h = Instance.new("Highlight")
                        h.Name = "NovaESP"
                        h.FillColor = Color3.fromRGB(255, 0, 0)
                        h.FillTransparency = 0.4
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
                        h.Parent = char
                     end
                  end
               end
               task.wait(1)
            end
         end)
      else
         -- Limpiar marcas
         for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("NovaESP") then
               p.Character.NovaESP:Destroy()
            end
         end
      end
   end,
})

-- 2. PESTAÑA: EVENTO 💀
local EventTab = Window:CreateTab("Evento 💀", 4483362458)
_G.AutoFarm = false

EventTab:CreateToggle({
   Name = "Auto-Farm Seguro",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if _G.AutoFarm then
         task.spawn(function()
            while _G.AutoFarm do
               pcall(function()
                  local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                  for _, obj in pairs(game.Workspace:GetDescendants()) do
                     if _G.AutoFarm and (obj.Name:lower():find("sombrero") or obj.Name:lower():find("hat")) then
                        if obj:IsA("BasePart") then
                           root.CFrame = obj.CFrame * CFrame.new(0, 2, 0)
                           task.wait(0.5)
                           firetouchinterest(root, obj, 0)
                           firetouchinterest(root, obj, 1)
                        end
                     end
                  end
               end)
               task.wait(1.5)
            end
         end)
      end
   end,
})

-- 3. PESTAÑA: MEJORAS ⚡
local SpeedTab = Window:CreateTab("Mejoras ⚡", 4483362458)

_G.HitboxActive = false
SpeedTab:CreateToggle({
   Name = "🎯 Hitbox (Cabeza Gigante)",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      if _G.HitboxActive then
         for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
               pcall(function()
                  local head = p.Character.Head
                  head.Size = Vector3.new(20, 20, 20)
                  head.Transparency = 0.5
                  head.CanCollide = false
                  head.Massless = true
               end)
            end
         end
      else
         for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") then
               pcall(function()
                  p.Character.Head.Size = Vector3.new(1.2, 1.2, 1.2)
                  p.Character.Head.Transparency = 0
               end)
            end
         end
      end
   end,
})

SpeedTab:CreateSlider({
   Name = "Velocidad de Caminado",
   Range = {16, 250},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

SpeedTab:CreateButton({
   Name = "🔄 RESTABLECER VELOCIDAD",
   Callback = function()
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
      end
   end,
})
