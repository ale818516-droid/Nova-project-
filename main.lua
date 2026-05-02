local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Versión Anti-Expulsión",
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

-- PESTAÑA INICIO (Velocidad con Toggle)
local MainTab = Window:CreateTab("Inicio 🏠", 4483362458)
local speedEnabled = false

MainTab:CreateToggle({
   Name = "Velocidad Rápida (32)",
   CurrentValue = false,
   Flag = "SpeedToggle",
   Callback = function(Value)
      speedEnabled = Value
      local player = game.Players.LocalPlayer
      if speedEnabled then
         player.Character.Humanoid.WalkSpeed = 32
      else
         player.Character.Humanoid.WalkSpeed = 16 -- Velocidad normal de Roblox
      end
   end,
})

-- PESTAÑA ESPÍA (Solo Oponentes)
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
local espEnabled = false

SpyTab:CreateToggle({
   Name = "Ver Enemigos",
   CurrentValue = false,
   Flag = "ESP_Toggle",
   Callback = function(Value)
      espEnabled = Value
      if espEnabled then
         spawn(function()
            while espEnabled do
               for _, player in pairs(game.Players:GetPlayers()) do
                  -- Filtro: Solo jugadores que NO sean tú y que NO estén en tu equipo
                  if player ~= game.Players.LocalPlayer and player.Team ~= game.Players.LocalPlayer.Team and player.Character then
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
         -- Limpieza total al desactivar
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("EspHighlight") then
               player.Character.EspHighlight:Destroy()
            end
         end
      end
   end,
})
