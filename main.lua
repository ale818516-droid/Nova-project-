local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Monetización Activa",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true, 
   KeySettings = {
      Title = "🔑 Acceso Requerido",
      Subtitle = "Sigue los pasos para entrar",
      Note = "Haz clic abajo para copiar el link de la Key",
      FileName = "NovaKey_V3", -- Cambiamos el nombre para que no use la clave vieja
      SaveKey = false, 
      GrabKeyFromSite = false, 
      Key = {"Yisuhub2006-@"}, 
      Actions = {
            [1] = {
                Text = "Copiame el enlace para la Key",
                OnPress = function()
                    -- REEMPLAZA ESTO CON TU LINK DE PUBLICIDAD
                    setclipboard("https://link-de-tu-publicidad.com") 
                end,
            }
        }
   }
})

-- PESTAÑA ESPÍA
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
                  if p ~= game.Players.LocalPlayer and p.Character then
                     if not p.Character:FindFirstChild("NovaESP") then
                        local h = Instance.new("Highlight", p.Character)
                        h.Name = "NovaESP"
                        h.FillColor = Color3.fromRGB(255, 0, 0)
                        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                     end
                  end
               end
               task.wait(1)
            end
         end)
      end
   end,
})

-- PESTAÑA MEJORAS
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
