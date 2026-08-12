local Sniper = { running = false, whitelist = {"Leopard","Dragon","Venom","Dough","Spirit"} }
local Utils = _G.Utils
local LP = _G.LP

function Sniper:Start()
    if self.running then return end
    self.running = true
    task.spawn(function()
        while self.running do
            pcall(function()
                local fruits = Utils:FireRemote("GetFruits") or {}
                for _, fruit in pairs(fruits) do
                    if fruit and fruit.Position then
                        local name = fruit.Name or ""
                        for _, w in pairs(self.whitelist) do
                            if name:find(w) then
                                Utils:SafeTeleport(CFrame.new(fruit.Position.X, fruit.Position.Y + 5, fruit.Position.Z))
                                task.wait(0.1)
                                for _, obj in pairs(_G.WS:GetDescendants()) do
                                    if obj:IsA("Model") and obj.Name:find("Fruit") and obj:FindFirstChild("HumanoidRootPart") then
                                        local d = (LP.Character.HumanoidRootPart.Position - obj.HumanoidRootPart.Position).Magnitude
                                        if d < 10 then
                                            local tool = obj:FindFirstChildOfClass("Tool")
                                            if tool then tool.Parent = LP.Backpack end
                                        end
                                    end
                                end
                                task.wait(0.5)
                                break
                            end
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end)
end

function Sniper:Stop()
    self.running = false
end

return Sniper