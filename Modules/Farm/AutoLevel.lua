local AutoLevel = { running = false, noQuest = false }
local Utils = _G.Utils or require(...)
local LP = _G.LP or game:GetService("Players").LocalPlayer

function AutoLevel:Start()
    if self.running then return end
    self.running = true
    task.spawn(function()
        while self.running do
            pcall(function()
                local t = Utils:FindNearestNPC(200, 5)
                if t then
                    local root = t:FindFirstChild("HumanoidRootPart")
                    if root then
                        Utils:SafeTeleport(root.CFrame * CFrame.new(0, 20, 5))
                        task.wait(0.05)
                        Utils:Attack(t)
                        task.wait(0.3)
                    end
                else
                    task.wait(0.5)
                end
            end)
            task.wait()
        end
    end)
end

function AutoLevel:Stop()
    self.running = false
end

return AutoLevel