local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Edición Mobile 2026",
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

-- PESTAÑA: ESPÍA
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
_G.EspActive = false

SpyTab:CreateToggle({
   Name = "Rastreo de Jugadores",
   CurrentValue = false,
   Callback = function(Value)
      _G.EspActive = Value
      if _G.EspActive then
         spawn(function()
            while _G.EspActive do
               for _, player in pairs(game.Players:GetPlayers()) do
                  if player ~= game.Players.LocalPlayer and player.Character then
                     local highlight = player.Character:FindFirstChild("NovaESP") or Instance.new("Highlight")
                     highlight.Name = "NovaESP"
                     highlight.Parent = player.Character
                     highlight.FillColor = Color3.fromRGB(255, 0, 0)
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

-- PESTAÑA: EVENTO
local EventTab = Window:CreateTab("Evento 💀", 4483362458)
_G.RemoteFarm = false

EventTab:CreateToggle({
   Name = "Farm Remoto (Sin Teleport)",
   CurrentValue = false,
   Callback = function(Value)
      _G.RemoteFarm = Value
      if _G.RemoteFarm then
         spawn(function()
            while _G.RemoteFarm do
               for _, obj in pairs(game.Workspace:GetDescendants()) do
                  if _G.RemoteFarm and (obj.Name:lower():find("hat") or obj.Name:lower():find("sombrero") or obj.Name:lower():find("skull")) then
                     local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                     if root and (obj:IsA("BasePart") or obj:IsA("MeshPart")) then
                        -- Intento de recolección invisible
                        firetouchinterest(root, obj, 0)
                        firetouchinterest(root, obj, 1)
                        
                        local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then fireproximityprompt(prompt) end
                     end
                  end
               end
               task.wait(0.3)
            end
         end)
      end
   end,
})
