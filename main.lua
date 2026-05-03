local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ALEXX HUB VIP",
   LoadingTitle = "Proyecto Nova",
   LoadingSubtitle = "Creado por ALEXX",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true, 
   KeySettings = {
      Title = "🔑 Acceso Requerido",
      Subtitle = "Consigue la Key para entrar",
      Note = "Haz clic abajo para copiar el link de la Key",
      FileName = "NovaKeyConfig_Final", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Yisuhub2006-@"}, 
      Actions = {
            [1] = {
                Text = "Copiame el enlace para la Key",
                OnPress = function()
                    -- Este es un link directo a la clave para que no batalles ahora
                    setclipboard("https://pastebin.com/raw/S3u8Vv90") 
                    Rayfield:Notify({
                        Title = "¡Link Copiado!",
                        Content = "Pégalo en tu navegador para ver la clave.",
                        Duration = 5,
                        Image = 4483362458,
                    })
                end,
            }
        }
   }
})

-- PESTAÑA 1: EVENTO
local EventTab = Window:CreateTab("Evento 💀", 4483362458)
_G.AutoFarm = false

EventTab:CreateToggle({
   Name = "Auto-Farm Sombreros",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if _G.AutoFarm then
         task.spawn(function()
            while _G.AutoFarm do
               pcall(function()
                  local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                  for _, obj in pairs(game.Workspace:GetDescendants()) do
                     if _G.AutoFarm and (obj.Name:lower():find("sombrero") or obj.Name:lower():find("hat")) then
                        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                           root.CFrame = obj.CFrame
                           task.wait(0.3)
                           firetouchinterest(root, obj, 0)
                           firetouchinterest(root, obj, 1)
                        end
                     end
                  end
               end)
               task.wait(1)
            end
         end)
      end
   end,
})

-- PESTAÑA 2: MEJORAS
local SpeedTab = Window:CreateTab("Mejoras ⚡", 4483362458)
SpeedTab:CreateSlider({
   Name = "Velocidad",
   Range = {16, 250},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- PESTAÑA 3: ESPÍA
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
_G.EspActive = false
SpyTab:CreateToggle({
   Name = "Activar Marcado Rojo",
   CurrentValue = false,
   Callback = function(Value)
      _G.EspActive = Value
      if _G.EspActive then
         task.spawn(function()
            while _G.EspActive do
               for _, p in pairs(game.Players:GetPlayers()) do
                  if p ~= game.Players.LocalPlayer and p.Character and not p.Character:FindFirstChild("NovaESP") then
                     local h = Instance.new("Highlight", p.Character)
                     h.Name = "NovaESP"
                     h.FillColor = Color3.fromRGB(255, 0, 0)
                     h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                  end
               end
               task.wait(1)
            end
         end)
      end
   end,
})
