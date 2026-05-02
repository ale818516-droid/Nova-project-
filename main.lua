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

-- PESTAÑA INICIO
local MainTab = Window:CreateTab("Inicio 🏠", 4483362458)
MainTab:CreateToggle({
   Name = "Velocidad (32)",
   CurrentValue = false,
   Callback = function(Value)
      local hum = (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()):FindFirstChild("Humanoid")
      if hum then hum.WalkSpeed = Value and 32 or 16 end
   end,
})

-- PESTAÑA EVENTO (TELEPORT FARM FORZADO)
local EventTab = Window:CreateTab("Evento 💀", 4483362458)
_G.AutoFarmActive = false

EventTab:CreateToggle({
   Name = "Farm de Sombreros (Teleport)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarmActive = Value
      if _G.AutoFarmActive then
         spawn(function()
            while _G.AutoFarmActive do
               for _, obj in pairs(game.Workspace:GetDescendants()) do
                  if _G.AutoFarmActive and (obj.Name:lower():find("hat") or obj.Name:lower():find("sombrero") or obj.Name:lower():find("skull")) then
                     local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                     if root and (obj:IsA("BasePart") or obj:IsA("MeshPart")) then
                        root.CFrame = obj.CFrame
                        task.wait(0.2)
                     end
                  end
               end
               task.wait(0.5)
            end
         end)
      end
   end,
})
