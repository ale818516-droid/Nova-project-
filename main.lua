-- PESTAÑA ESPÍA (Con limpieza automática)
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
local espEnabled = false

SpyTab:CreateToggle({
   Name = "Ver Jugadores (ESP)",
   CurrentValue = false,
   Flag = "ESP_Toggle",
   Callback = function(Value)
      espEnabled = Value
      
      if espEnabled then
         -- Bucle para activar el ESP
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
                     end
                     highlight.Enabled = true
                  end
               end
               task.wait(1)
            end
         end)
      else
         -- ESTO ES LO QUE LIMPIA: Borra el efecto al desactivar
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
               local highlight = player.Character:FindFirstChild("EspHighlight")
               if highlight then
                  highlight:Destroy() -- Elimina el efecto por completo
               end
            end
         end
         
         Rayfield:Notify({
            Title = "ALEXX HUB VIP",
            Content = "Efecto Espía Eliminado",
            Duration = 2,
         })
      end
   end,
})
