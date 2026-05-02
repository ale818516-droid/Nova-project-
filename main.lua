local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Versión iPhone 14",
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
   Name = "Velocidad Rápida (32)",
   CurrentValue = false,
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = Value and 32 or 16
      end
   end,
})

-- PESTAÑA ESPÍA
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)
_G.EspActive = false

SpyTab:CreateToggle({
   Name = "Solo Enemigos",
   CurrentValue = false,
   Callback = function(Value)
      _G.EspActive = Value
      if _G.EspActive then
         spawn(function()
            while _G.EspActive do
               for _, player in pairs(game.Players:GetPlayers()) do
                  if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                     -- Solo oponentes
                     if player.Team ~= game.Players.LocalPlayer.Team or tostring(player.Team) == "nil" then
                        local highlight = player.Character:FindFirstChild("NovaESP")
                        if not highlight then
                           highlight = Instance.new("Highlight")
                           highlight.Name = "NovaESP"
                           highlight.Parent = player.Character
                           highlight.FillColor = Color3.fromRGB(255, 0, 0)
                           highlight.FillTransparency = 0.5
                        end
                     end
                  end
               end
               task.wait(1)
            end
         end)
      else
         -- LIMPIEZA INSTANTÁNEA
         for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
               local h = player.Character:FindFirstChild("NovaESP")
               if h then h:Destroy() end
            end
         end
      end
   end,
})