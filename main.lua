local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Edición Evento 2026",
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

-- PESTAÑA 1: INICIO (Velocidad)
local MainTab = Window:CreateTab("Inicio 🏠", 4483362458)

MainTab:CreateToggle({
   Name = "Velocidad (32)",
   CurrentValue = false,
   Callback = function(Value)
      local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      if hum then
         hum.WalkSpeed = Value and 32 or 16
      end
   end,
})

-- PESTAÑA 2: ESPÍA (Solo Enemigos)
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
_G.EspActive = false

SpyTab:CreateToggle({
   Name = "Ver Enemigos",
   CurrentValue = false,
   Callback = function(Value)
      _G.EspActive = Value
      if _G.EspActive then
         spawn(function()
            while _G.EspActive do
               for _, player in pairs(game.Players:GetPlayers()) do
                  if player ~= game.Players.LocalPlayer and player.Character then
                     if player.Team ~= game.Players.LocalPlayer.Team or tostring(player.Team) == "nil" then
                        local highlight = player.Character:FindFirstChild("NovaESP")
                        if not highlight then
                           highlight = Instance.new("Highlight")
                           highlight.Name = "NovaESP"
                           highlight.Parent = player.Character
                           highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        end
                     end
                  end
               end
               task.wait(1)
            end
         end)
      else
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("NovaESP") then
               player.Character.NovaESP:Destroy()
            end
         end
      end
   end,
})
-- PESTAÑA EVENTO (FORZADO DE SOMBREROS)
local EventTab = Window:CreateTab("Evento 💀", 4483362458)
_G.AutoFarmActive = false

EventTab:CreateToggle({
   Name = "Farm de Sombreros (Forzado)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarmActive = Value
      if _G.AutoFarmActive then
         spawn(function()
            while _G.AutoFarmActive do
               for _, obj in pairs(game.Workspace:GetDescendants()) do
                  -- Busca por nombre de sombrero o carpetas de evento
                  if _G.AutoFarmActive and (obj.Name:lower():find("hat") or obj.Name:lower():find("sombrero") or obj.Name:lower():find("mayo")) then
                     local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                     if root and (obj:IsA("BasePart") or obj:IsA("MeshPart")) then
                        -- Teletransporte directo al sombrero
                        root.CFrame = obj.CFrame
                        
                        -- Simulamos el click de recolección
                        local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                           fireproximityprompt(prompt)
                        else
                           firetouchinterest(root, obj, 0)
                           firetouchinterest(root, obj, 1)
                        end
                        task.wait(0.1) -- Velocidad para iPhone 14
                     end
                  end
               end
               task.wait(0.5)
            end
         end)
      end
   end,
})