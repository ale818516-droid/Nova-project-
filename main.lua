local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Generador de clave única
local characters = "ABCDEFG12345"
local sessionKey = ""
for i = 1, 6 do
    local r = math.random(1, #characters)
    sessionKey = sessionKey .. string.sub(characters, r, r)
end

print("🔑 Clave Generada: " .. sessionKey)

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Sistema Completo 2026",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true,
   KeySettings = {
      Title = "Acceso Requerido",
      Subtitle = "Consigue tu llave dinámica",
      Note = "La clave cambia cada sesión. Copia el link abajo.",
      FileName = "NovaKey_FinalV2", 
      SaveKey = false, 
      GrabKeyFromSite = false,
      Key = {sessionKey}, 
      Actions = {
            [1] = {
                Text = "Copiame el enlace para la Key",
                OnPress = function()
                    -- PEGA AQUÍ TU ENLACE DE LINKVERTISE
                    setclipboard("https://tu-link-de-linkvertise.com") 
                end,
            }
        }
   }
})

-- PESTAÑA 1: EVENTO (RESTAURADA)
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

-- PESTAÑA 2: MEJORAS (VELOCIDAD)
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
