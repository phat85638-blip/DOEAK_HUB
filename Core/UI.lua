-- ============================================
-- DOEAK HUB - UI (v2.0)
-- ============================================
local UI = {}
local ScreenGui, MainFrame
local Tabs = {}
local CurrentTab = nil
local COLORS = {
    Background = Color3.fromRGB(15,15,20),
    Primary = Color3.fromRGB(255,200,50),   -- Vàng toggle ON
    Secondary = Color3.fromRGB(30,30,40),
    Text = Color3.fromRGB(255,255,255),
    Dark = Color3.fromRGB(0,0,0),
    Grey = Color3.fromRGB(200,200,200),
}

function UI:CreateGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DOEAK_Hub"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false
    
    -- Floating Button
    local float = Instance.new("TextButton")
    float.Size = UDim2.new(0, 60, 0, 60)
    float.Position = UDim2.new(0.9, -30, 0.1, 30)
    float.BackgroundColor3 = COLORS.Dark
    float.BackgroundTransparency = 0.1
    float.BorderSizePixel = 2
    float.BorderColor3 = COLORS.Primary
    float.Text = "🐉"
    float.TextColor3 = COLORS.Primary
    float.TextSize = 30
    float.Font = Enum.Font.GothamBold
    float.Parent = ScreenGui
    local fcorner = Instance.new("UICorner")
    fcorner.CornerRadius = UDim.new(1,0)
    fcorner.Parent = float
    
    -- Main Frame
    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 450, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -200)
    MainFrame.BackgroundColor3 = COLORS.Background
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,10)
    corner.Parent = MainFrame
    MainFrame.Visible = false
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,40)
    title.Position = UDim2.new(0,0,0,0)
    title.BackgroundTransparency = 1
    title.Text = "🐉 DOEAK Hub v2.0"
    title.TextColor3 = COLORS.Primary
    title.TextSize = 24
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.TextYAlignment = Enum.TextYAlignment.Bottom
    title.Font = Enum.Font.GothamBold
    title.Parent = MainFrame
    
    -- Close button
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0,30,0,30)
    close.Position = UDim2.new(1,-35,0,5)
    close.BackgroundColor3 = COLORS.Secondary
    close.Text = "✕"
    close.TextColor3 = COLORS.Text
    close.TextSize = 18
    close.Font = Enum.Font.GothamBold
    close.Parent = MainFrame
    local ccorner = Instance.new("UICorner")
    ccorner.CornerRadius = UDim.new(1,0)
    ccorner.Parent = close
    close.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)
    
    -- Tab Container
    local tabCont = Instance.new("Frame")
    tabCont.Size = UDim2.new(0,110,1,-40)
    tabCont.Position = UDim2.new(0,0,0,40)
    tabCont.BackgroundColor3 = COLORS.Secondary
    tabCont.BackgroundTransparency = 0.3
    tabCont.BorderSizePixel = 0
    tabCont.Parent = MainFrame
    local tcorner = Instance.new("UICorner")
    tcorner.CornerRadius = UDim.new(0,8)
    tcorner.Parent = tabCont
    
    -- Content
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1,-120,1,-10)
    content.Position = UDim2.new(0,115,0,5)
    content.BackgroundTransparency = 1
    content.Parent = MainFrame
    
    UI._tabContainer = tabCont
    UI._contentFrame = content
    
    -- Floating button toggle
    local visible = false
    float.MouseButton1Click:Connect(function()
        visible = not visible
        MainFrame.Visible = visible
    end)
    
    -- Drag
    local drag = false
    float.MouseButton1Down:Connect(function() drag = true end)
    float.MouseButton1Up:Connect(function() drag = false end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if drag and input.UserInputType == Enum.UserInputType.MouseMovement then
            float.Position = UDim2.new(0, input.Position.X - 30, 0, input.Position.Y - 30)
        end
    end)
    
    return MainFrame
end

function UI:CreateTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-10,0,40)
    btn.Position = UDim2.new(0,5,0,5 + #Tabs * 45)
    btn.BackgroundColor3 = Color3.fromRGB(25,25,35)
    btn.BackgroundTransparency = 0.5
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(200,200,200)
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.GothamMedium
    btn.Parent = UI._tabContainer
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,6)
    corner.Parent = btn
    
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1,0,1,0)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.Parent = UI._contentFrame
    
    local data = { Button = btn, Content = content, Name = name }
    table.insert(Tabs, data)
    btn.MouseButton1Click:Connect(function() UI:SwitchTab(data) end)
    if #Tabs == 1 then UI:SwitchTab(data) end
    return content
end

function UI:SwitchTab(tab)
    for _, t in pairs(Tabs) do
        t.Content.Visible = false
        t.Button.BackgroundColor3 = Color3.fromRGB(25,25,35)
        t.Button.TextColor3 = Color3.fromRGB(200,200,200)
    end
    tab.Content.Visible = true
    tab.Button.BackgroundColor3 = Color3.fromRGB(50,40,20)
    tab.Button.TextColor3 = COLORS.Primary
    CurrentTab = tab
end

function UI:AddToggle(parent, text, default, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,-10,0,35)
    f.BackgroundTransparency = 1
    f.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.6,0,1,0)
    l.Position = UDim2.new(0,5,0,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = COLORS.Text
    l.TextSize = 14
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.GothamMedium
    l.Parent = f
    
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0,60,0,25)
    b.Position = UDim2.new(0.9,-60,0.5,-12.5)
    b.BackgroundColor3 = default and COLORS.Primary or Color3.fromRGB(50,50,50)
    b.Text = default and "ON" or "OFF"
    b.TextColor3 = COLORS.Text
    b.TextSize = 12
    b.Font = Enum.Font.GothamBold
    b.Parent = f
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,4)
    corner.Parent = b
    
    local state = default or false
    b.MouseButton1Click:Connect(function()
        state = not state
        b.BackgroundColor3 = state and COLORS.Primary or Color3.fromRGB(50,50,50)
        b.Text = state and "ON" or "OFF"
        if callback then pcall(callback, state) end
    end)
    return { SetState = function(s) state = s; b.BackgroundColor3 = s and COLORS.Primary or Color3.fromRGB(50,50,50); b.Text = s and "ON" or "OFF"; if callback then pcall(callback, s) end end, GetState = function() return state end }
end

function UI:AddButton(parent, text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9,0,0,35)
    b.Position = UDim2.new(0.05,0,0,0)
    b.BackgroundColor3 = Color3.fromRGB(40,40,50)
    b.Text = text
    b.TextColor3 = COLORS.Text
    b.TextSize = 14
    b.Font = Enum.Font.GothamMedium
    b.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,4)
    corner.Parent = b
    b.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
    end)
    return b
end

function UI:AddDropdown(parent, text, options, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,-10,0,35)
    f.BackgroundTransparency = 1
    f.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.5,0,1,0)
    l.Position = UDim2.new(0,5,0,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = COLORS.Text
    l.TextSize = 14
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.GothamMedium
    l.Parent = f
    
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0.35,0,0.8,0)
    dropdown.Position = UDim2.new(0.6,0,0.1,0)
    dropdown.BackgroundColor3 = Color3.fromRGB(40,40,50)
    dropdown.Text = options[1] or "Select"
    dropdown.TextColor3 = COLORS.Text
    dropdown.TextSize = 13
    dropdown.Font = Enum.Font.GothamMedium
    dropdown.Parent = f
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,4)
    corner.Parent = dropdown
    
    local expanded = false
    dropdown.MouseButton1Click:Connect(function()
        expanded = not expanded
        if expanded then
            -- Show options (simple list)
            for i, opt in pairs(options) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0.35,0,0.3,0)
                btn.Position = UDim2.new(0.6,0,0.1 + i*0.25,0)
                btn.BackgroundColor3 = Color3.fromRGB(30,30,40)
                btn.Text = opt
                btn.TextColor3 = COLORS.Text
                btn.TextSize = 13
                btn.Font = Enum.Font.GothamMedium
                btn.Parent = f
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0,4)
                corner.Parent = btn
                btn.MouseButton1Click:Connect(function()
                    dropdown.Text = opt
                    if callback then pcall(callback, opt) end
                    expanded = false
                    for _, child in pairs(f:GetChildren()) do
                        if child ~= l and child ~= dropdown and child:IsA("TextButton") and child.Name ~= "Dropdown" then
                            child:Destroy()
                        end
                    end
                end)
            end
        else
            for _, child in pairs(f:GetChildren()) do
                if child ~= l and child ~= dropdown and child:IsA("TextButton") then
                    child:Destroy()
                end
            end
        end
    end)
end

function UI:AddSlider(parent, text, min, max, default, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,-10,0,50)
    f.BackgroundTransparency = 1
    f.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.6,0,0,20)
    l.Position = UDim2.new(0,5,0,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = COLORS.Text
    l.TextSize = 14
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.GothamMedium
    l.Parent = f
    
    local val = Instance.new("TextLabel")
    val.Size = UDim2.new(0.3,0,0,20)
    val.Position = UDim2.new(0.7,0,0,0)
    val.BackgroundTransparency = 1
    val.Text = tostring(default or min)
    val.TextColor3 = COLORS.Primary
    val.TextSize = 14
    val.TextXAlignment = Enum.TextXAlignment.Right
    val.Font = Enum.Font.GothamMedium
    val.Parent = f
    
    local s = Instance.new("Frame")
    s.Size = UDim2.new(0.9,0,0,6)
    s.Position = UDim2.new(0.05,0,0,30)
    s.BackgroundColor3 = Color3.fromRGB(50,50,60)
    s.BorderSizePixel = 0
    s.Parent = f
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(1,0)
    sc.Parent = s
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default or min)/max,0,1,0)
    fill.BackgroundColor3 = COLORS.Primary
    fill.BorderSizePixel = 0
    fill.Parent = s
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(1,0)
    fc.Parent = fill
    
    local value = default or min
    local dragging = false
    local input = game:GetService("UserInputService")
    s.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
    s.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging then
            local mouse = input:GetMouseLocation()
            local pos = s.AbsolutePosition
            local size = s.AbsoluteSize
            local rel = math.clamp((mouse.X - pos.X) / size.X, 0, 1)
            value = min + (max - min) * rel
            value = math.round(value)
            fill.Size = UDim2.new(rel,0,1,0)
            val.Text = tostring(value)
            if callback then pcall(callback, value) end
        end
    end)
    return { SetValue = function(v) value = math.clamp(v,min,max); local rel = (value-min)/(max-min); fill.Size = UDim2.new(rel,0,1,0); val.Text = tostring(value); if callback then pcall(callback, value) end end, GetValue = function() return value end }
end

function UI:AddLabel(parent, text, color)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-10,0,25)
    l.Position = UDim2.new(0,5,0,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or COLORS.Grey
    l.TextSize = 14
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Font = Enum.Font.GothamMedium
    l.Parent = parent
    return l
end

function UI:Notify(msg, err)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(0,300,0,50)
    n.Position = UDim2.new(0.5,-150,0.8,0)
    n.BackgroundColor3 = err and Color3.fromRGB(200,50,50) or Color3.fromRGB(50,50,60)
    n.Text = msg
    n.TextColor3 = COLORS.Text
    n.TextSize = 14
    n.TextWrapped = true
    n.Font = Enum.Font.GothamMedium
    n.Parent = ScreenGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,8)
    corner.Parent = n
    task.wait(3)
    n:Destroy()
end

function UI:Init()
    self:CreateGUI()
    return self
end

return UI