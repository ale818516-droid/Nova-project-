local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Versión 2.0 - Control Total",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true,
   KeySettings = {
      Title = "Acceso Requerido",
      Subtitle = "Sistema de Llave",
      Note = "Key: Yisuhub2006-@",
      FileName = "NovaKey",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"Yisuhub2006-@"}
   }
})

-- PESTAÑA COMBATE (Autoshoot)
local CombatTab = Window:CreateTab("Combate ⚔️", 4483362458)
local autoShootEnabled = false
local vim = game:GetService("VirtualInputManager")

CombatTab:CreateToggle({
   Name = "Autoshoot Móvil",
   CurrentValue = false,
   Flag = "AutoShoot",
   Callback = function(Value)
      autoShootEnabled = Value
      if autoShootEnabled then
         spawn(function()
            while autoShootEnabled do
               local player = game.Players.LocalPlayer
               local mouse = player:GetMouse()
               local target = mouse.Target
               if target and target.Parent:FindFirstChild("Humanoid") then
                  vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                  task.wait(0.05)
                  vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
               end
               task.wait(0.1)
            end
         end)
      end
   end,
})

-- PESTAÑA ESPÍA (Con borrado automático)
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
local espEnabled = false

SpyTab:CreateToggle({
   Name = "Ver Jugadores (ESP)",
   CurrentValue = false,
   Flag = "ESP_Toggle",
   Callback = function(Value)
      espEnabled = Value
      if espEnabled then
         spawn(function()
            while espEnabled do
               for _, player in pairs(game.Players:GetPlayers()) do
                  if player ~= game.Players.LocalPlayer and player.Character then
                     local char = player.Character
                     local highlight = char:FindFirstChild("EspHighlight")
                     if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "EspHighlight"
                        highlight.Parent = char
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.FillTransparency = 0.5
                     end
                     highlight.Enabled = true
                  end
               end
               task.wait(1)
            end
         end)
      else
         -- ESTO ELIMINA EL EFECTO AL DESACTIVAR
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("EspHighlight") then
               player.Character.EspHighlight:Destroy()
            end
         end
      end
   end,
})
