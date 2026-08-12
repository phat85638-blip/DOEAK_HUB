local ESPCore = { running = false, objects = {} }
local Utils = _G.Utils
local Players = game:GetService("Players")
local LP = _G.LP
local WS = _G.WS

function ESPCore:CreateESP(obj)
    if not obj or not obj:FindFirstChild("HumanoidRootPart") then return end
    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Color = Color3.fromRGB(255, 80, 80)
    box.Filled = false
    box.Transparency = 0.3
    box.Visible = true
    local label = Drawing.new("Text")
    label.Text = obj.Name or ""
    label.Color = Color3.fromRGB(255, 80, 80)
    label.Size = 16
    label.Center = true
    label.Visible = true
    local dist = Drawing.new("Text")
    dist.Text = ""
    dist.Color = Color3.fromRGB(255, 255, 255)
    dist.Size = 12
    dist.Center = true
    dist.Visible = true
    self.objects[obj] = { box = box, label = label, dist = dist }
end

function ESPCore:Update()
    local cam = WS.CurrentCamera
    if not cam then return end
    for obj, data in pairs(self.objects) do
        if obj and obj:FindFirstChild("HumanoidRootPart") and obj.Humanoid and obj.Humanoid.Health > 0 then
            local root = obj.HumanoidRootPart
            local pos, on = cam:WorldToViewportPoint(root.Position)
            local dist = (cam.CFrame.Position - root.Position).Magnitude
            local size = math.clamp(60 / (dist / 20), 20, 100)
            if on then
                data.box.Position = Vector2.new(pos.X - size/2, pos.Y - size/2)
                data.box.Size = Vector2.new(size, size)
                data.box.Visible = true
                data.label.Text = obj.Name
                data.label.Position = Vector2.new(pos.X, pos.Y - size/2 - 18)
                data.label.Visible = true
                data.dist.Text = math.floor(dist) .. "m"
                data.dist.Position = Vector2.new(pos.X, pos.Y + size/2 + 12)
                data.dist.Visible = true
            else
                data.box.Visible = false; data.label.Visible = false; data.dist.Visible = false
            end
        else
            data.box.Visible = false; data.label.Visible = false; data.dist.Visible = false
        end
    end
end

function ESPCore:Start()
    if self.running then return end
    self.running = true
    task.spawn(function()
        while self.running do
            pcall(function()
                for obj, data in pairs(self.objects) do
                    if not obj or not obj.Parent then
                        data.box:Remove(); data.label:Remove(); data.dist:Remove()
                        self.objects[obj] = nil
                    end
                end
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if not self.objects[p.Character] then self:CreateESP(p.Character) end
                    end
                end
                self:Update()
            end)
            task.wait(0.1)
        end
    end)
end

function ESPCore:Stop()
    self.running = false
    for _, data in pairs(self.objects) do pcall(function() data.box:Remove(); data.label:Remove(); data.dist:Remove() end) end
    self.objects = {}
end

return ESPCore