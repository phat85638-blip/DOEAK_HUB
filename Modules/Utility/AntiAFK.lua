local AntiAFK = { running = false }
local LP = _G.LP

function AntiAFK:Start()
    if self.running then return end
    self.running = true
    task.spawn(function()
        while self.running do
            pcall(function()
                local char = LP.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local root = char.HumanoidRootPart
                    root.CFrame = root.CFrame + CFrame.new(0, 0, 1)
                    task.wait(0.05)
                    root.CFrame = root.CFrame - CFrame.new(0, 0, 1)
                end
            end)
            task.wait(10)
        end
    end)
end

function AntiAFK:Stop()
    self.running = false
end

return AntiAFK