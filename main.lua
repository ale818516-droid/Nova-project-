local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Menú por Separado",
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

-- ==========================================
-- SECCIÓN 1: INICIO (VELOCIDAD)
-- ==========================================
local MainTab = Window:CreateTab("Inicio 🏠", 4483362458)

MainTab:CreateToggle({
   Name = "Velocidad Rápida (32)",
   CurrentValue = false,
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = Value and 32 or 16
      end
   end,
})

-- ==========================================
-- SECCIÓN 2: ESPÍA (SOLO ENEMIGOS)
-- ==========================================
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
_G.EspActive = false

SpyTab:CreateToggle({
   Name = "Ver Solo Oponentes",
   CurrentValue = false,
   Callback = function(Value)
      _G.EspActive = Value
      if _G.EspActive then
         spawn(function()
            while _G.EspActive do
               for _, player in pairs(game.Players:GetPlayers()) do
                  if player ~= game.Players.LocalPlayer and player.Character then
                     -- Filtro para no marcar a tu propio equipo
                     if player.Team ~= game.Players.LocalPlayer.Team or tostring(player.Team) == "nil" then
                        local char = player.Character
                        local highlight = char:FindFirstChild("NovaESP")
                        if not highlight then
                           highlight = Instance.new("Highlight")
                           highlight.Name = "NovaESP"
                           highlight.Parent = char
                           highlight.FillColor = Color3.fromRGB(255, 0, 0)
                           highlight.FillTransparency = 0.5
                        end
                     end
                  end
               end
               task.wait(1)
            end
         end)
      else
         -- Borrado inmediato al apagar
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("NovaESP") then
               player.Character.NovaESP:Destroy()
            end
         end
      end
   end,
})

-- ==========================================
-- SECCIÓN 3: EVENTO (AUTO FARM SEPARADO)
-- ==========================================
local EventTab = Window:CreateTab("Evento 💀", 4483362458)
local farmEnabled = false

EventTab:CreateToggle({
   Name = "Auto Farm Cinco de Mayo",
   CurrentValue = false,
   Callback = function(Value)
      farmEnabled = Value
      if farmEnabled then
         spawn(function()
            while farmEnabled do
               -- Busca las calaveras en todo el mapa
               for _, obj in pairs(game.Workspace:GetDescendants()) do
                  if farmEnabled and (obj.Name == "Calavera" or obj.Name == "Skull") and obj:IsA("BasePart") then
                     local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                     if root then
                        root.CFrame = obj.CFrame
                        task.wait(0.5) -- Tiempo para que el juego registre que la tocaste
                     end
                  end
               end
               task.wait(1)
            end
         end)
      end
   end,
})
