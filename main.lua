--[[
    PROYECTO NOVA - ALEXX HUB VIP
    Version: 2026 - FULL RESTORED + HITBOX + SOUND
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ENLACE DE MONETIZACIÓN ACTUALIZADO
local NuevoLink = "https://link-hub.net/5492042/tYPu1E3EJOo0"

-- COPIADO AUTOMÁTICO AL INICIAR
setclipboard(NuevoLink)

-- NOTIFICACIÓN DE COPIADO
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ALEXX HUB VIP",
    Text = "¡Nuevo enlace copiado! Consigue la llave.",
    Duration = 8
})

-- SISTEMA DE SONIDO AL INICIAR
local function PlayStartSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590662766" 
    sound.Volume = 1
    sound.Parent = game:GetService("SoundService")
    sound:Play()
    task.wait(2)
    sound:Destroy()
end

local Window = Rayfield:CreateWindow({
   Name = "ALEXX HUB VIP",
   LoadingTitle = "Project Nova",
   LoadingSubtitle = "Security 2026",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true, 
   KeySettings = {
      Title = "🔑 ACCESS SYSTEM",
      Subtitle = "Key Required (Link in Clipboard)",
      Note = "Pega el link en tu navegador para obtener la clave", 
      FileName = "NovaKey_Mayo_V3", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"1228£\\+Hh"} 
   }
})

task.spawn(PlayStartSound)

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
   Name = "Smart ESP (Opponents Only)",
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
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
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

-- 3. TAB: ENHANCEMENTS ⚡
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

_G.FlyEnabled = false
SpeedTab:CreateToggle({
   Name = "🕊️ Fly Mode",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyEnabled = Value
      local bPart = localPlayer.Character:WaitForChild("HumanoidRootPart")
      local flySpeed = 50
      task.spawn(function()
         while _G.FlyEnabled do
            local velocity = Vector3.new(0,0.1,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then velocity = velocity + (camera.CFrame.LookVector * flySpeed) end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then velocity = velocity - (camera.CFrame.LookVector * flySpeed) end
            bPart.Velocity = velocity
            task.wait()
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

SpeedTab:CreateSlider({
   Name = "Sensibilidad (Camera)",
   Range = {1, 10},
   Increment = 0.1,
   CurrentValue = 1,
   Callback = function(Value)
       UserInputService.MouseDeltaSensitivity = Value
   end,
})

SpeedTab:CreateButton({
   Name = "🏃 Velocidad Normal",
   Callback = function()
      if localPlayer.Character:FindFirstChild("Humanoid") then
         localPlayer.Character.Humanoid.WalkSpeed = 16
      end
   end,
})

SpeedTab:CreateButton({
   Name = "🚀 Ultra FPS Booster",
   Callback = function()
      for _, v in pairs(game:GetDescendants()) do
         if v:IsA("BasePart") and not v:IsDescendantOf(localPlayer.Character) then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
         elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
         elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
         end
      end
      Lighting.GlobalShadows = false
      Lighting.FogEnd = 9e9
      settings().Rendering.QualityLevel = 1
      Rayfield:Notify({Title = "ALEXX HUB", Content = "Lag eliminado!", Duration = 3})
   end,
})

-- 4. TAB: COMBAT ⚔️
local CombatTab = Window:CreateTab("Combat ⚔️", 4483362458)

-- SISTEMA DE HITBOX
_G.HitboxActive = false
RunService.RenderStepped:Connect(function()
    if _G.HitboxActive then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= localPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                head.Size = Vector3.new(7, 7, 7)
                head.Color = Color3.fromRGB(0, 0, 255) 
                head.Transparency = 0.6
                head.CanCollide = false
                head.Massless = true
            end
        end
    end
end)

CombatTab:CreateToggle({
   Name = "🎯 Hitbox Azul",
   CurrentValue = false,
   Callback = function(Value)
      _G.HitboxActive = Value
      if not Value then
         for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") then
               p.Character.Head.Size = Vector3.new(1.15, 1.15, 1.15)
               p.Character.Head.Transparency = 0
            end
         end
      end
   end,
})

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
            if closest then 
               camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Character.Head.Position) 
            end
            task.wait()
         end
      end)
   end,
})

-- 5. TAB: CONTROL ⚙️
local ControlTab = Window:CreateTab("Control ⚙️", 4483362458)

ControlTab:CreateButton({
   Name = "🗑️ Limpiar Chat (Anti-Hack Accusation)",
   Callback = function()
       local chat = localPlayer.PlayerGui:FindFirstChild("Chat")
       if chat then
           for _, v in pairs(chat:GetDescendants()) do
               if v:IsA("TextLabel") or v:IsA("Frame") then
                   v.Visible = false
               end
           end
           Rayfield:Notify({Title = "Chat Limpio", Content = "Mensajes ocultos con éxito", Duration = 3})
       end
   end,
})

ControlTab:CreateButton({
   Name = "🌌 Cambiar de Servidor",
   Callback = function()
       local Http = game:GetService("HttpService")
       local TPS = game:GetService("TeleportService")
       local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
       local function NextServer()
           local Servers = Http:JSONDecode(game:HttpGet(Api))
           for _, s in pairs(Servers.data) do
               if s.playing < s.maxPlayers and s.id ~= game.JobId then
                   TPS:TeleportToPlaceInstance(game.PlaceId, s.id, localPlayer)
               end
           end
       end
       NextServer()
   end,
})

ControlTab:CreateToggle({
   Name = "☀️ Full Bright",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         Lighting.Brightness = 2
         Lighting.ClockTime = 14
         Lighting.FogEnd = 100000
         Lighting.GlobalShadows = false
      else
         Lighting.Brightness = 1
         Lighting.GlobalShadows = true
      end
   end,
})

local PlayerLabel = ControlTab:CreateLabel("Jugadores: " .. #Players:GetPlayers())
Players.PlayerAdded:Connect(function() PlayerLabel:Set("Jugadores: " .. #Players:GetPlayers()) end)
Players.PlayerRemoving:Connect(function() PlayerLabel:Set("Jugadores: " .. #Players:GetPlayers()) end)

local function checkModerator(player)
    if player:GetRankInGroup(game.CreatorId) >= 200 then 
        Rayfield:Notify({
            Title = "⚠️ MOD DETECTADO",
            Content = "El moderador " .. player.Name .. " ha entrado.",
            Duration = 10,
        })
    end
end
Players.PlayerAdded:Connect(checkModerator)

ControlTab:CreateButton({
   Name = "🔍 Escanear Moderadores",
   Callback = function()
      local found = false
      for _, p in pairs(Players:GetPlayers()) do
         if p:GetRankInGroup(game.CreatorId) >= 200 then
            Rayfield:Notify({Title = "ALERTA", Content = p.Name .. " es moderador.", Duration = 5})
            found = true
         end
      end
      if not found then
         Rayfield:Notify({Title = "Seguro", Content = "No hay moderadores activos.", Duration = 3})
      end
   end,
})

ControlTab:CreateSlider({
   Name = "JumpPower (Salto)",
   Range = {50, 500},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(Value)
      if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
         local hum = localPlayer.Character.Humanoid
         hum.UseJumpPower = true 
         hum.JumpPower = Value
      end
   end,
})

ControlTab:CreateButton({
   Name = "🦿 Salto Normal",
   Callback = function()
      if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
         local hum = localPlayer.Character.Humanoid
         hum.JumpPower = 50
         Rayfield:Notify({Title = "ALEXX HUB", Content = "Salto restablecido!", Duration = 2})
      end
   end,
})

ControlTab:CreateButton({
   Name = "🔄 Re-join Server",
   Callback = function()
      TeleportService:Teleport(game.PlaceId, localPlayer)
   end,
})
