--[[
    PROYECTO NOVA - ALEXX HUB VIP
    Versión: Anti-Muerte & Reset Speed
    Fix: Evento Cinco de Mayo
]]

-- Limpieza de interfaces previas para que no salga el menú gris
for _, v in pairs(game.CoreGui:GetChildren()) do
    if v:IsA("ScreenGui") and (v.Name:find("Rayfield") or v:FindFirstChild("Main")) then
        v:Destroy()
    end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ALEXX HUB VIP",
   LoadingTitle = "Proyecto Nova",
   LoadingSubtitle = "Seguridad 2026",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true, 
   KeySettings = {
      Title = "🔑 SISTEMA DE ACCESO",
      Subtitle = "Contraseña Requerida",
      Note = "Consigue la clave en el canal de ALEXX", 
      FileName = "NovaKey_Privada_2026", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Yisuhub2006-@"} 
   }
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
                  local char = game.Players.LocalPlayer.Character
                  local root = char and char:FindFirstChild("HumanoidRootPart")
                  local hum = char and char:FindFirstChild("Humanoid")

                  if hum and hum.Health > 0 then
                     for _, obj in pairs(game.Workspace:GetDescendants()) do
                        if _G.AutoFarm and (obj.Name:lower():find("sombrero") or obj.Name:lower():find("hat")) then
                           if obj:IsA("BasePart") then
                              -- FIX: Nos movemos 2 unidades ARRIBA del sombrero para evitar morir
                              root.CFrame = obj.CFrame * CFrame.new(0, 2, 0)
                              task.wait(0.5)
                              firetouchinterest(root, obj, 0)
                              firetouchinterest(root, obj, 1)
                           end
                        end
                     end
                  end
               end)
               task.wait(1.2) -- Pausa para que el servidor no te mate
            end
         end)
      end
   end,
})

-- PESTAÑA: MEJORAS ⚡ (CON BOTÓN DE RESET)
local SpeedTab = Window:CreateTab("Mejoras ⚡", 4483362458)

SpeedTab:CreateSlider({
   Name = "Velocidad de Caminado",
   Range = {16, 250},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

SpeedTab:CreateButton({
   Name = "Restablecer Velocidad",
   Callback = function()
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
         Rayfield:Notify({
            Title = "Velocidad Restablecida",
            Content = "Tu velocidad ha vuelto a 16.",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})
