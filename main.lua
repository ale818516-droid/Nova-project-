--[[
    PROYECTO NOVA - ALEXX HUB VIP
    Estructura Original - Privacidad de Credenciales
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
      Note = "Consigue el acceso en el canal oficial", -- Se quitó la contraseña de aquí
      FileName = "NovaKey_Final_2026", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Yisuhub2006-@"} -- La clave sigue siendo la misma, pero ya no se muestra en el texto
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
               for _, p in pairs(game.Players:GetPlayers()) do
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
         for _, p in pairs(game.Players:GetPlayers()) do
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

-- HITBOX (BOTÓN MANUAL)
SpeedTab:CreateButton({
   Name = "🎯 ACTIVAR HITBOX (CABEZA)",
   Callback = function()
      for _, p in pairs(game.Players:GetPlayers()) do
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
      Rayfield:Notify({
         Title = "Hitbox Aplicada",
         Content = "Efecto activo para esta partida.",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

-- CONTROL DE VELOCIDAD
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

-- BOTÓN DE RESET
SpeedTab:CreateButton({
   Name = "🔄 RESTABLECER VELOCIDAD",
   Callback = function()
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
      end
   end,
})
