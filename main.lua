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

-- PESTAÑA 1: INICIO
local MainTab = Window:CreateTab("Inicio 🏠", 4483362458)
MainTab:CreateToggle({
   Name = "Velocidad (32)",
   CurrentValue = false,
   Callback = function(Value)
      local hum = (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):FindFirstChild("Humanoid")
      if hum then hum.WalkSpeed = Value and 32 or 16 end
   end,
})

-- PESTAÑA 2: ESPÍA (ESP)
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
_G.EspActive = false

SpyTab:CreateToggle({
   Name = "Ver Jugadores",
   CurrentValue = false,
   Callback = function(Value)
      _G.EspActive = Value
      if _G.EspActive then
         spawn(function()
            while _G.EspActive do
               for _, player in pairs(game.Players:GetPlayers()) do
                  if player ~= game.Players.LocalPlayer and player.Character then
                     local highlight = player.Character:FindFirstChild("NovaESP")
                     if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "NovaESP"
                        highlight.Parent = player.Character
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
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

-- PESTAÑA 3: EVENTO (FARM REMOTO SIN TELEPORT)
local EventTab = Window:CreateTab("Evento 💀", 4483362458)
_G.RemoteFarm = false

EventTab:CreateToggle({
   Name = "Farm Remoto Invisible",
   CurrentValue = false,
   Callback = function(Value)
      _G.RemoteFarm = Value
      if _G.RemoteFarm then
         spawn(function()
            while _G.RemoteFarm do
               for _, obj in pairs(game.Workspace:GetDescendants()) do
                  -- Busca sombreros, calaveras u objetos del evento
                  if _G.RemoteFarm and (obj.Name:lower():find("hat") or obj.Name:lower():find("sombrero") or obj.Name:lower():find("skull")) then
                     local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                     if root and (obj:IsA("BasePart") or obj:IsA("MeshPart")) then
                        -- Simula el toque remoto sin mover al personaje
                        firetouchinterest(root, obj, 0)
                        firetouchinterest(root, obj, 1)
                        
                        -- Activa botones de recolección si existen
                        local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then
                           fireproximityprompt(prompt)
                        end
                     end
                  end
               end
               task.wait(0.5) -- Tiempo de escaneo equilibrado
            end
         end)
      end
   end,
})