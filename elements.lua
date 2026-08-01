local Elements = {}

function Elements.new(Page, Colors, TweenService)

    local TabSection = {}

    function TabSection:CreateButton(text, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = Page
        Button.BackgroundColor3 = Colors.PanelBg
        Button.Size = UDim2.new(0,420,0,32)
        Button.Text = text

        if callback then
            Button.MouseButton1Click:Connect(callback)
        end
    end

    return TabSection
end

return Elements