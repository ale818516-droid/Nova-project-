local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Bienvenido",
   ConfigurationSaving = { Enabled = false, FileName = "NovaProject" },
   KeySystem = true,
   KeySettings = {
      Title = "Acceso Requerido",
      Subtitle = "Sistema de Llave",
      Note = "Key: Yisuhub2006-@",
      FileName = "NovaKey",
      SaveKey = false,
      GrabKeyFromSite = true,
      Key = {"https://raw.githubusercontent.com/ale818516-droid/Nova-project-/main/key.txt"}
   }
})

-- PESTAÑA PRINCIPAL
local MainTab = Window:CreateTab("Principal 🏠", 4483362458)
MainTab:CreateButton({
   Name = "Velocidad Rápida",
   Callback = function()
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
   end,
})

-- PESTAÑA DE COMBATE (Autoshoot)
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

-- PESTAÑA ESPÍA (ESP)
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
local espEnabled = false

SpyTab:CreateToggle({
   Name = "Ver Jugadores",
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
                     if not char:FindFirstChild("EspHighlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "EspHighlight"
                        highlight.Parent = char
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                     end
                     char.EspHighlight.Enabled = true
                  end
               end
               task.wait(1)
            end
         end)
      else
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("EspHighlight") then
               player.Character.EspHighlight:Destroy()
            end
         end
      end
   end,
}}