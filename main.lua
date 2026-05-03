--[[
    PROYECTO NOVA - ALEXX HUB VIP
    Versión: 2026 - Corrección de Hitbox Off + Noclip + Anti-Kill
]]

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

-- 1. PESTAÑA: ESPÍA 👁️
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
                  if p ~= game.Players.LocalPlayer and p.Character then
                     if not p.Character:FindFirstChild("NovaESP") then
                        local h = Instance.new("Highlight", p.Character)
                        h.Name = "NovaESP"
                        h.FillColor = Color3.fromRGB(255, 0, 0)
                     end
                  end
               end
               task.wait(1)
            end
         end)
      else
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

-- NOCLIP
_G.Noclip = false
SpeedTab:CreateToggle({
   Name = "🧱 Noclip (Atravesar Paredes)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Noclip = Value
      game:GetService("RunService").Stepped:Connect(function()
         if _G.Noclip and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
               if v:IsA("BasePart") then v.CanCollide = false end
            end
         end
      end)
   end,
})

-- ANTI-KILL
_G.AntiKill = false
SpeedTab:CreateToggle({
   Name = "🛡️ Anti-Kill (Protección)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiKill = Value
      if _G.AntiKill then
         task.spawn(function()
            while _G.AntiKill do
               pcall(function()
                  local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                  if hum and hum.Health < 20 and hum.Health > 0 then
                     hum.Health = 100
                  end
               end)
               task.wait(0.1)
            end
         end)
      end
   end,
})

-- HITBOX (CORREGIDA LA DESACTIVACIÓN)
_G.HitboxActive = false
SpeedTab:CreateToggle({
   Name = "🎯 Hitbox (Cabeza Gigante)",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      if _G.HitboxActive then
         task.spawn(function()
            while _G.HitboxActive do
               for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                  if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                     p.Character.Head.Size = Vector3.new(20, 20, 20)
                     p.Character.Head.Transparency = 0.5
                  end
               end
               task.wait(1)
            end
         end)
      else
         -- ESTA PARTE AHORA RESTABLECE EL TAMAÑO AL APAGAR EL TOGGLE
         for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") then
               p.Character.Head.Size = Vector3.new(1.2, 1.2, 1.2)
               p.Character.Head.Transparency = 0
            end
         end
      end
   end,
})

-- VELOCIDAD
SpeedTab:CreateSlider({
   Name = "Velocidad de Caminado",
   Range = {16, 250},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

SpeedTab:CreateButton({
   Name = "🔄 RESTABLECER VELOCIDAD",
   Callback = function()
      if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
      end
   end,
})
