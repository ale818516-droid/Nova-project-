-- Forzar el cierre de otros menús para que no se mezclen
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Esto destruye cualquier ventana previa de Rayfield
pcall(function()
    Rayfield:Destroy()
end)

local Window = Rayfield:CreateWindow({
   Name = "Proyecto Nova",
   LoadingTitle = "ALEXX HUB VIP",
   LoadingSubtitle = "Versión Oficial",
   ConfigurationSaving = { Enabled = false, FileName = "NovaProject" },
   KeySystem = true,
   KeySettings = {
      Title = "Acceso Requerido",
      Subtitle = "Sistema de Llave",
      Note = "Key: Yisuhub2006-@",
      FileName = "NovaKey",
      SaveKey = false,
      GrabKeyFromSite = true,
      Key = {"https://raw.githubusercontent.com/ale818516-droid/Nova-project-/main/key.txt"}
   }
})

-- PESTAÑAS (Asegúrate de que este bloque esté después de Window)
local MainTab = Window:CreateTab("Principal 🏠", 4483362458)
local CombatTab = Window:CreateTab("Combate ⚔️", 4483362458)
local SpyTab = Window:CreateTab("Espía 👁️", 4483362458)

-- Botón de Velocidad
MainTab:CreateButton({
   Name = "Velocidad Rápida",
   Callback = function()
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
   end,
})

-- El resto de tus funciones de Combate y Espía van aquí abajo...
