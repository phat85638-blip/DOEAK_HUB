local AutoMastery = { running = false, weapon = "Melee" }
local Utils = _G.Utils
local LP = _G.LP

function AutoMastery:Start()
    if self.running then return end
    self.running = true
    task.spawn(function()
        while self.running do
            pcall(function()
                local char = LP.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                local best, bestD = nil, math.huge
                local enemies = _G.WS:FindFirstChild("Enemies")
                if enemies then
                    for _, e in pairs(enemies:GetChildren()) do
                        if e:IsA("Model") and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                            local r = e:FindFirstChild("HumanoidRootPart")
                            if r then
                                local d = (root.Position - r.Position).Magnitude
                                if d < bestD and d < 150 then best, bestD = e, d end
                            end
                        end
                    end
                end
                if best then
                    local pos = best.HumanoidRootPart.Position
                    Utils:SafeTeleport(CFrame.new(pos.X, pos.Y + 25, pos.Z))
                    task.wait(0.05)
                    Utils:Attack(best)
                    task.wait(0.2)
                else
                    task.wait(0.5)
                end
            end)
            task.wait()
        end
    end)
end

function AutoMastery:Stop()
    self.running = false
end

return AutoMastery