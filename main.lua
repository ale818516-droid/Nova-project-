--[[
    PROYECTO NOVA - ALEXX HUB VIP
    Versión: Limpieza Total & Contraseña Oculta
    Estado: Final 2026
]]

-- FUERZA EL CIERRE DE OTROS MENÚS ANTES DE EMPEZAR
for _, v in pairs(game.CoreGui:GetChildren()) do
    if v:FindFirstChild("Main") or v.Name == "Rayfield" then
        v:Destroy()
    end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ALEXX HUB VIP",
   LoadingTitle = "Proyecto Nova",
   LoadingSubtitle = "Seguridad de ALEXX 2026",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true, 
   KeySettings = {
      Title = "🔑 SISTEMA DE ACCESO",
      Subtitle = "Ingresa la Clave Privada",
      Note = "Consigue la clave en mi canal de YouTube", 
      FileName = "NovaKey_Final_V8", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Yisuhub2006-@"}, -- CLAVE ÚNICA OCULTA
      Actions = {
         {
            Text = "COPIAR LINK DE KEY",
            OnPress = function()
               setclipboard("https://link-hub.net/5510597/0Cz9xat3a36r")
               Rayfield:Notify({
                  Title = "¡Copiado!",
                  Content = "Ve a Safari para obtener tu clave.",
                  Duration = 5,
                  Image = 4483362458,
               })
            end,
         },
      }
   }
})

-- PESTAÑA: ESPÍA 👁️
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
      else
         for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("NovaESP") then
               p.Character.NovaESP:Destroy()
            end
         end
      end
   end,
})

-- PESTAÑA: EVENTO 💀 (FIX PARA NO MORIR)
local EventTab = Window:CreateTab("Evento 💀", 4483362458)
_G.AutoFarm = false
EventTab:CreateToggle({
   Name = "Auto-Farm Seguro",
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
                        -- FIX: Teletransporte seguro para evitar morir
                        root.CFrame = obj.CFrame * CFrame.new(0, 2, 0)
                        task.wait(0.5)
                        firetouchinterest(root, obj, 0)
                        firetouchinterest(root, obj, 1)
                     end
                  end
               end)
               task.wait(1.5)
            end
         end)
      end
   end,
})

-- PESTAÑA: MEJORAS ⚡
local SpeedTab = Window:CreateTab("Mejoras ⚡", 4483362458)
SpeedTab:CreateSlider({
   Name = "Velocidad de Caminado",
   Range = {16, 250},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- BOTÓN DE RESETEAR (Como pediste en image_20.png)
SpeedTab:CreateButton({
   Name = "Restablecer Velocidad",
   Callback = function()
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
      Rayfield:Notify({
         Title = "Reset Exitoso",
         Content = "Velocidad de ALEXX a 16.",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})
