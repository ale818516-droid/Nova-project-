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
-- PESTAÑA EVENTO (FORZADO TOTAL)
local EventTab = Window:CreateTab("Evento 💀", 4483362458)
_G.AutoFarmEvent = false

EventTab:CreateToggle({
   Name = "Farm Forzado (Pruébame)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarmEvent = Value
      if _G.AutoFarmEvent then
         spawn(function()
            while _G.AutoFarmEvent do
               -- Escaneamos TODO el juego, no solo el Workspace visible
               for _, obj in pairs(game:GetDescendants()) do
                  if _G.AutoFarmEvent and (obj.Name:lower():find("skull") or obj.Name:lower():find("calavera")) then
                     local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                     
                     if root then
                        -- MÉTODO A: ProximityPrompt (Botones de interactuar)
                        local prompt = obj:FindFirstChildOfClass("ProximityPrompt") or obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt then
                           fireproximityprompt(prompt)
                        end
                        
                        -- MÉTODO B: TouchInterest (Objetos de tocar)
                        if obj:IsA("BasePart") then
                           firetouchinterest(root, obj, 0)
                           firetouchinterest(root, obj, 1)
                        elseif obj:IsA("Model") then
                           local p = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                           if p then
                              firetouchinterest(root, p, 0)
                              firetouchinterest(root, p, 1)
                           end
                        end
                     end
                  end
               end
               task.wait(0.1) -- Velocidad máxima para tu video
            end
         end)
      end
   end,
})