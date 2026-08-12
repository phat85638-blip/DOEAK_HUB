local AutoBoss = { running = false, bossName = "Saber Expert" }
local Utils = _G.Utils
local LP = _G.LP
local BOSS_NAMES = {"Saber Expert","Greybeard","Ice Admiral","Diamond","Fishman Lord","Warden","Chief Warden","Darkbeard","Order","Rumble","Frostbite","Cryo","Pirate King"}

function AutoBoss:FindBoss()
    local char = LP.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local best, bestD = nil, math.huge
    for _, obj in pairs(_G.WS:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
            local name = obj.Name
            for _, bn in pairs(BOSS_NAMES) do
                if name:find(bn) then
                    local r = obj:FindFirstChild("HumanoidRootPart")
                    if r then
                        local d = (root.Position - r.Position).Magnitude
                        if d < bestD and d < 300 then best, bestD = obj, d end
                    end
                    break
                end
            end
        end
    end
    return best
end

function AutoBoss:Start()
    if self.running then return end
    self.running = true
    task.spawn(function()
        while self.running do
            pcall(function()
                local boss = self:FindBoss()
                if boss then
                    local char = LP.Character
                    if char then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root and boss:FindFirstChild("HumanoidRootPart") then
                            Utils:SafeTeleport(boss.HumanoidRootPart.CFrame * CFrame.new(0, 15, 5))
                            task.wait(0.05)
                            Utils:Attack(boss)
                            task.wait(0.3)
                        end
                    end
                else
                    task.wait(1)
                end
            end)
            task.wait()
        end
    end)
end

function AutoBoss:Stop()
    self.running = false
end

return AutoBoss