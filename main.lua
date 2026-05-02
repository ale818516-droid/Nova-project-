local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "Cargando Script...",
   LoadingSubtitle = "por ALEXX HUB VIP",
   ConfigurationSaving = {
      Enabled = false,
      FileName = "NovaProject"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Acceso Requerido",
      Subtitle = "Sistema de Llave",
      Note = "Consigue la key en el enlace de Linkvertise",
      FileName = "NovaKey",
      SaveKey = false,
      GrabKeyFromSite = true,
      Key = {"https://raw.githubusercontent.com/ale818516-droid/Nova-project-/main/key.txt"}
   }
})
-- Pestaña del ESP (con la lógica de apagado automático que corregimos)
local Tab = Window:CreateTab("Visuales", 4483362458)

_G.ESP_Inteligente = false

Tab:CreateToggle({
   Name = "ESP Oponentes (Auto-Partida)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP_Inteligente = Value
      
      if _G.ESP_Inteligente then
         task.spawn(function()
            while _G.ESP_Inteligente do
               local player = game.Players.LocalPlayer
               local char = player.Character
               local hrp = char and char:FindFirstChild("HumanoidRootPart")
               
               -- Solo funciona fuera del lobby y contra oponentes
               if hrp and hrp.Position.Magnitude > 300 then 
                  for _, rival in pairs(game.Players:GetPlayers()) do
                     if rival ~= player and rival.Character then
                        if not player:IsFriendsWith(rival.UserId) then
                           local rHrp = rival.Character:FindFirstChild("HumanoidRootPart")
                           if rHrp and (hrp.Position - rHrp.Position).Magnitude < 250 then
                              if not rival.Character:FindFirstChild("EfectoNova") then
                                 local h = Instance.new("Highlight", rival.Character)
                                 h.Name = "EfectoNova"
                                 h.FillColor = Color3.fromRGB(255, 0, 0)
                                 h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                              end
                           end
                        end
                     end
                  end
               else
                  for _, p in pairs(game.Players:GetPlayers()) do
                     if p.Character and p.Character:FindFirstChild("EfectoNova") then
                        p.Character.EfectoNova:Destroy()
                     end
                  end
               end
               task.wait(0.5)
            end
         end)
      else
         -- Limpieza inmediata al apagar
         for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("EfectoNova") then
               p.Character.EfectoNova:Destroy()
            end
         end
      end
   end,
}}
-- Pestaña del Autoshoot (con la lógica de apagado automático que corregimos)
local Tab = Window:CreateTab("Combate", 4483362458)
-- Variable para controlar el Autoshoot
local autoShootEnabled = false
local vim = game:GetService("VirtualInputManager")
-- Función de Autoshoot optimizada para móvil
Tab:CreateToggle({
   Name = "Autoshoot Móvil 🔫",
   CurrentValue = false,
   Flag = "AutoShootToggle",
   Callback = function(Value)
      autoShootEnabled = Value
      
      spawn(function()
         while autoShootEnabled do
            local player = game.Players.LocalPlayer
            local mouse = player:GetMouse()
            local target = mouse.Target
            
            -- Detecta si apuntas a un enemigo
            if target and target.Parent:FindFirstChild("Humanoid") then
               -- Simula un toque en la pantalla (mejor para iPhone/Android)
               vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
               task.wait(0.05)
               vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            end
            task.wait(0.1) -- Ajusta la velocidad aquí
         end
      end)

      if Value then
         Rayfield:Notify({
            Title = "ALEXX HUB VIP",
            Content = "Autoshoot Móvil Activado",
            Duration = 3,
         })
      end
   end,
})
