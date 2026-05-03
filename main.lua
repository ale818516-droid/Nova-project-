--[[
    PROYECTO NOVA - ALEXX HUB VIP
    Versión: Kill All, Espía & Anti-Death
    Desarrollado para: ALEXX
]]

-- Limpia menús previos
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
      Note = "Consigue la clave en el canal de ALEXX", 
      FileName = "NovaKey_Final_2026", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Yisuhub2006-@"} 
   }
})

-- PESTAÑA: ESPÍA 👁️
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
                        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
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

-- PESTAÑA: EVENTO 💀 (FIX ANTIDEATH)
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
                  local char = game.Players.LocalPlayer.Character
                  local root = char and char:FindFirstChild("HumanoidRootPart")
                  local hum = char and char:FindFirstChild("Humanoid")

                  if hum and hum.Health > 0 then
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
                  end
               end)
               task.wait(1.5)
            end
         end)
      end
   end,
})

-- PESTAÑA: MEJORAS ⚡
local SpeedTab = Window:CreateTab("Mejoras ⚡", 4483362458)

-- FUNCIÓN: KILL ALL (NUEVA)
SpeedTab:CreateButton({
   Name = "💀 MATAR A TODOS (KILL ALL)",
   Callback = function()
      for _, p in pairs(game.Players:GetPlayers()) do
         if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
            pcall(function()
               p.Character.Humanoid.Health = 0
            end)
         end
      end
      Rayfield:Notify({
         Title = "Kill All Ejecutado",
         Content = "Se ha intentado eliminar a todos los jugadores.",
         Duration = 3,
         Image = 4483362458,
      })
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
   Name = "Restablecer Velocidad",
   Callback = function()
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
         Rayfield:Notify({
            Title = "Reseteado",
            Content = "Velocidad a 16",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})
