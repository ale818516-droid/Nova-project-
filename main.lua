-- PESTAÑA ESPÍA (Solo Oponentes y con Desactivación Real)
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
local espLoop = nil -- Variable para controlar el proceso

SpyTab:CreateToggle({
   Name = "Ver Enemigos",
   CurrentValue = false,
   Flag = "ESP_Toggle",
   Callback = function(Value)
      if Value then
         -- Iniciamos el bucle solo si es verdadero
         _G.EspActive = true
         spawn(function()
            while _G.EspActive do
               for _, player in pairs(game.Players:GetPlayers()) do
                  if player ~= game.Players.LocalPlayer and player.Character then
                     -- Filtro de oponentes: Solo marca si NO es de tu equipo
                     if player.Team ~= game.Players.LocalPlayer.Team or tostring(player.Team) == "nil" then
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
               end
               task.wait(1)
            end
         end)
      else
         -- DETENER EL PROCESO Y BORRAR TODO
         _G.EspActive = false
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
               local h = player.Character:FindFirstChild("EspHighlight")
               if h then 
                  h:Destroy() -- Esto borra el efecto rojo al momento
               end
            end
         end
      end
   end,
})

-- PESTAÑA VELOCIDAD (Con opción de Apagado)
local MainTab = Window:CreateTab("Inicio 🏠", 4483362458)
MainTab:CreateToggle({
   Name = "Velocidad (32)",
   CurrentValue = false,
   Callback = function(Value)
      local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      if hum then
         hum.WalkSpeed = Value and 32 or 16 -- 16 es la velocidad normal
      end
   end,
})
