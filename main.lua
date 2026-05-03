local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- GENERADOR DE CLAVE AL AZAR
local caracteres = "ABCDEFG123456"
local claveGenerada = ""
for i = 1, 6 do
    local rand = math.random(1, #caracteres)
    claveGenerada = claveGenerada .. string.sub(caracteres, rand, rand)
end

-- ESTO MUESTRA LA CLAVE EN TU CONSOLA (SOLO PARA TI)
print("La clave de esta sesión es: " .. claveGenerada)

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Monetización Dinámica 2026",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true,
      KeySettings = {
      Title = "🔑 Acceso Requerido",
      Subtitle = "Consigue la Key para entrar",
      Note = "Haz clic abajo para copiar el link", -- Cambia este texto
      FileName = "NovaKeyConfig_V2", -- Cambia el nombre del archivo para forzar el reset
      SaveKey = false, 
      GrabKeyFromSite = false, 
      Key = {"Yisuhub2006-@"}, 
      Actions = {
            [1] = {
                Text = "Copiame el enlace para la Key",
                OnPress = function()
                    setclipboard("TU_LINK_DE_LINKVERTISE_AQUÍ") 
                    print("Enlace copiado")
                end,
            }
        }
   }



-- PESTAÑA 1: ESPÍA (RESTAURADO)
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

-- PESTAÑA 2: EVENTO (DETECCIÓN DE CINCO DE MAYO)
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

-- PESTAÑA 3: MEJORAS (VELOCIDAD)
local SpeedTab = Window:CreateTab("Mejoras ⚡", 4483362458)

SpeedTab:CreateSlider({
   Name = "Velocidad de Caminado",
   Range = {16, 250},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

SpeedTab:CreateButton({
   Name = "Restablecer Velocidad",
   Callback = function()
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
   end,
})
