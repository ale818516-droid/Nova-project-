local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova | Sistema de Keys",
   LoadingTitle = "Verificando Acceso...",
   LoadingSubtitle = "by chucho-cmd",
   ConfigurationSaving = { Enabled = false },
   
   -- CONFIGURACIÓN DEL SISTEMA DE LLAVES
      KeySystem = true,
      KeySettings = {
      Title = "Nova - Acceso Requerido",
      Subtitle = "Consigue tu llave para entrar",
      Note = "La llave cambia cada 24 horas",
      FileName = "NovaKey", 
      SaveKey = false, -- Cambiado a false para que caduque
      GrabKeyFromSite = true, -- Cambiado a true para leer de GitHub
      Key = {"https://raw.githubusercontent.com/ale818516-droid/Nova-project-/main/key.txt"}
   }
})
-- El enlace de monetización que aparecerá en la ventana de carga
Rayfield:Notify({
   Title = "Consigue tu Key",
   Content = "Enlace: linkvertise.com/tu-link-aqui",
   Duration = 10
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
})
