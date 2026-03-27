
end

CrearB("ESP", 10, "NovaE")
CrearB("AIM & SHOOT", 50, "NovaA")
CrearB("SPEED", 90, "NovaS")
CrearB("AUTO CLICK", 130, "NovaAC")

M.MouseButton1Click:Connect(function() F.Visible = not F.Visible end)

R.RenderStepped:Connect(function()
    if _G.NovaE then
        for _, p in pairs(P:GetPlayers()) do
            if p ~= L and p.Character then
                local h = p.Character:FindFirstChild("NH")
                if p.Team ~= L.Team then
                    if not h then h = Instance.new("Highlight", p.Character) h.Name = "NH" h.FillColor = Color3.fromRGB(255, 0, 0) end
                end
            end
        end
    end
    if L.Character and L.Character:FindFirstChild("Humanoid") then
        L.Character.Humanoid.WalkSpeed = _G.NovaS and 100 or 16
    end
    if _G.NovaA then
        local t, d = nil, 500
        for _, p in pairs(P:GetPlayers()) do
            if p ~= L and p.Character and p.Character:FindFirstChild("Head") and p.Team ~= L.Team then
                local dist = (L.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist < d then t, d = p.Character.Head, dist end
            end
        end
        if t then 
            C.CFrame = CFrame.new(C.CFrame.Position, t.Position)
            VU:Button1Down(Vector2.new(0,0), C.CFrame)
        end
    end
    if _G.NovaAC then VU:Button1Down(Vector2.new(0,0), C.CFrame) end
end)
