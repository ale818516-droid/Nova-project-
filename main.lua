--[[
    PROYECTO NOVA - ALEXX HUB VIP
    Version: 2026 - ULTIMATE HITBOX TRACKING
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ALEXX HUB VIP",
   LoadingTitle = "Project Nova",
   LoadingSubtitle = "Security 2026",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true, 
   KeySettings = {
      Title = "🔑 ACCESS SYSTEM",
      Subtitle = "Key Required",
      Note = "Get the key from the official channel", 
      FileName = "NovaKey_Final_2026", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Yisuhub2006-@"} 
   }
})

-- SERVICES
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- 1. TAB: ESP 👁️
local SpyTab = Window:CreateTab("ESP 👁️", 4483362458)
_G.EspActive = false

SpyTab:CreateToggle({
   Name = "Enable Red Highlights",
   CurrentValue = false,
   Callback = function(Value)
      _G.EspActive = Value
      if _G.EspActive then
         task.spawn(function()
            while _G.EspActive do
               for _, p in pairs(Players:GetPlayers()) do
                  if p ~= localPlayer and p.Character then
                     if not p.Character:FindFirstChild("NovaESP") then
                        local h = Instance.new("Highlight", p.Character)
                        h.Name = "NovaESP"
                        h.FillColor = Color3.fromRGB(255, 0, 0)
                     end
                  end
               end
               task.wait(1)
            end
         end)
      else
         for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("NovaESP") then
               p.Character.NovaESP:Destroy()
            end
         end
      end
   end,
})

-- 2. TAB: AUTOMATION 🤖
local AutoTab = Window:CreateTab("Automation 🤖", 4483362458)

_G.AntiAFK = false
AutoTab:CreateToggle({
   Name = "Anti-AFK (Stay Connected)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiAFK = Value
      if _G.AntiAFK then
         localPlayer.Idled:Connect(function()
            if _G.AntiAFK then
               game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), camera.CFrame)
               task.wait(1)
               game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), camera.CFrame)
            end
         end)
      end
   end,
})

_G.AutoFarm = false
AutoTab:CreateToggle({
   Name = "Safe Auto-Farm",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if _G.AutoFarm then
         task.spawn(function()
            while _G.AutoFarm do
               pcall(function()
                  local root = localPlayer.Character.HumanoidRootPart
                  for _, obj in pairs(game.Workspace:GetDescendants()) do
                     if _G.AutoFarm and (obj.Name:lower():find("sombrero") or obj.Name:lower():find("hat")) then
                        if obj:IsA("BasePart") then
                           root.CFrame = obj.CFrame * CFrame.new(0, 2, 0)
                           task.wait(0.5)
                           firetouchinterest(root, obj, 0)
                           firetouchinterest(root, obj, 1)
                        end
                     end
                  end
               end)
               task.wait(1.5)
            end
         end)
      end
   end,
})

AutoTab:CreateButton({
   Name = "🔄 Auto-Rejoin Server",
   Callback = function()
      TeleportService:Teleport(game.PlaceId, localPlayer)
   end,
})

-- 3. TAB: UTILITIES 🛠️
local UtilityTab = Window:CreateTab("Utilities 🛠️", 4483362458)

UtilityTab:CreateButton({
   Name = "🚀 Server Hopper",
   Callback = function()
      local Http = game:GetService("HttpService")
      local TPS = game:GetService("TeleportService")
      local Api = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
      local _srvs = Http:JSONDecode(game:HttpGet(Api))
      for _, s in pairs(_srvs.data) do
         if s.playing < s.maxPlayers and s.id ~= game.JobId then
            TPS:TeleportToPlaceInstance(game.PlaceId, s.id, localPlayer)
            break
         end
      end
   end,
})

_G.MobileTP = false
UtilityTab:CreateToggle({
   Name = "📍 Tap to Teleport",
   CurrentValue = false,
   Callback = function(Value)
      _G.MobileTP = Value
      UserInputService.InputBegan:Connect(function(input)
         if _G.MobileTP and input.UserInputType == Enum.UserInputType.Touch then
            local touchPos = input.Position
            local unitRay = camera:ScreenPointToRay(touchPos.X, touchPos.Y)
            local result = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000)
            if result and localPlayer.Character then
               localPlayer.Character:MoveTo(result.Position + Vector3.new(0, 3, 0))
            end
         end
      end)
   end,
})

-- 4. TAB: ENHANCEMENTS ⚡
local SpeedTab = Window:CreateTab("Enhancements ⚡", 4483362458)

_G.Noclip = false
SpeedTab:CreateToggle({
   Name = "🧱 Noclip",
   CurrentValue = false,
   Callback = function(Value)
      _G.Noclip = Value
      RunService.Stepped:Connect(function()
         if _G.Noclip and localPlayer.Character then
            for _, v in pairs(localPlayer.Character:GetDescendants()) do
               if v:IsA("BasePart") then v.CanCollide = false end
            end
         end
      end)
   end,
})

_G.HitboxActive = false
SpeedTab:CreateToggle({
   Name = "🎯 Dynamic Hitbox",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      task.spawn(function()
         while _G.HitboxActive do
            for _, p in pairs(Players:GetPlayers()) do
               if p ~= localPlayer and p.Character and p.Character:FindFirstChild("Head") then
                  -- Seguimiento agresivo: se asegura de que la cabeza siempre sea grande y siga al cuerpo
                  local head = p.Character.Head
                  head.Size = Vector3.new(20, 20, 20)
                  head.Transparency = 0.5
                  head.CanCollide = false
                  head.Massless = true -- Evita que el peso de la hitbox detenga al jugador
               end
            end
            task.wait() -- Actualización inmediata en cada ciclo
         end
         
         -- RESET AL DESACTIVAR
         for _, p in pairs(Players:GetPlayers()) do
            if p ~= localPlayer and p.Character and p.Character:FindFirstChild("Head") then
               p.Character.Head.Size = Vector3.new(1.15, 1.15, 1.15)
               p.Character.Head.Transparency = 0
               p.Character.Head.CanCollide = true
            end
         end
      end)
   end,
})

SpeedTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 250},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      if localPlayer.Character:FindFirstChild("Humanoid") then
         localPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

SpeedTab:CreateButton({
   Name = "🚀 FPS Booster",
   Callback = function()
      for _, v in pairs(game:GetDescendants()) do
         if v:IsA("BasePart") and not v:IsDescendantOf(localPlayer.Character) then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
         end
      end
      Lighting.GlobalShadows = false
      Rayfield:Notify({Title = "ALEXX HUB", Content = "Lag reducido!", Duration = 2})
   end,
})

-- 5. TAB: COMBAT ⚔️
local CombatTab = Window:CreateTab("Combat ⚔️", 4483362458)

_G.Aimbot = false
CombatTab:CreateToggle({
   Name = "🎯 Hard Lock",
   CurrentValue = false,
   Callback = function(Value)
      _G.Aimbot = Value
      task.spawn(function()
         while _G.Aimbot do
            local closest = nil
            local shortestDistance = math.huge
            for _, p in pairs(Players:GetPlayers()) do
               if p ~= localPlayer and p.Character and p.Character:FindFirstChild("Head") then
                  local pos, onScreen = camera:WorldToViewportPoint(p.Character.Head.Position)
                  if onScreen then
                     local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                     if distance < shortestDistance then
                        shortestDistance = distance
                        closest = p
                     end
                  end
               end
            end
            if closest then camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Character.Head.Position) end
            task.wait()
         end
      end)
   end,
})

CombatTab:CreateButton({
   Name = "👤 TP Behind Nearest Player",
   Callback = function()
      local closest = nil
      local dist = math.huge
      for _, p in pairs(Players:GetPlayers()) do
         if p ~= localPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (localPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then dist = d; closest = p end
         end
      end
      if closest then
         local enemyHRP = closest.Character.HumanoidRootPart
         localPlayer.Character:SetPrimaryPartCFrame(enemyHRP.CFrame * CFrame.new(0, 0, 3))
         Rayfield:Notify({Title = "ALEXX HUB VIP", Content = "TP detrás de " .. closest.Name, Duration = 2})
      end
   end,
})

-- 6. TAB: WORLD 🌍
local WorldTab = Window:CreateTab("World 🌍", 4483362458)

WorldTab:CreateButton({
   Name = "🌌 Galaxy Skybox",
   Callback = function()
      local sky = Instance.new("Sky", Lighting)
      sky.SkyboxBk = "rbxassetid://159454299"
      sky.SkyboxDn = "rbxassetid://159454296"
      sky.SkyboxFt = "rbxassetid://159454293"
      sky.SkyboxLf = "rbxassetid://159454286"
      sky.SkyboxRt = "rbxassetid://159454288"
      sky.SkyboxUp = "rbxassetid://159454290"
      Lighting.ClockTime = 0
   end,
})
