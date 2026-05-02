-- PESTAÑA ESPÍA (Solo Oponentes y con limpieza)
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
                  -- FILTRO MEJORADO: No eres tú, no es tu equipo, y tiene un cuerpo (Character)
                  if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                     
                     -- Solo marcar si NO es de tu equipo o si el juego no tiene equipos definidos
                     if player.Team ~= game.Players.LocalPlayer.Team or tostring(player.Team) == "nil" then
                        local char = player.Character
                        local highlight = char:FindFirstChild("EspHighlight")
                        
                        if not highlight then
                           highlight = Instance.new("Highlight")
                           highlight.Name = "EspHighlight"
                           highlight.Parent = char
                           highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Rojo para enemigos
                           highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                           highlight.FillTransparency = 0.5
                        end
                        highlight.Enabled = true
                     end
                  end
               end
               task.wait(1)
            end
         end)
      else
         -- LIMPIEZA: Borrar todo cuando se desactiva
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
               local h = player.Character:FindFirstChild("EspHighlight")
               if h then h:Destroy() end
            end
         end
      end
   end,
})
