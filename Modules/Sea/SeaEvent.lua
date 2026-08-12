local SeaEvent = { running = false }
local Utils = _G.Utils

function SeaEvent:Start()
    if self.running then return end
    self.running = true
    task.spawn(function()
        while self.running do
            pcall(function()
                local event = Utils:FindSeaEvent()
                if event and event:FindFirstChild("HumanoidRootPart") then
                    local pos = event.HumanoidRootPart.Position
                    Utils:SafeTeleport(CFrame.new(pos.X, pos.Y + 20, pos.Z + 10))
                    task.wait(0.05)
                    Utils:Attack(event)
                    task.wait(0.3)
                else
                    task.wait(0.5)
                end
            end)
            task.wait()
        end
    end)
end

function SeaEvent:Stop()
    self.running = false
end

return SeaEvent