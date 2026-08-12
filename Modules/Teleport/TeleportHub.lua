local TeleportHub = {}
local LP = _G.LP
local ISLANDS = { Sea1 = CFrame.new(-500, 0, 500), Sea2 = CFrame.new(1500, 0, -1500), Sea3 = CFrame.new(-3000, 0, 3000) }

function TeleportHub:To(sea)
    local cf = ISLANDS[sea]
    if not cf then return end
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = cf * CFrame.new(0, 10, 0) end
end

function TeleportHub:ShowPlayerList(parent)
    local btn = UI:AddButton(parent, "🔄 Refresh Players", function()
        local list = Utils:GetPlayerList()
        for _, child in pairs(parent:GetChildren()) do if child.Name == "PlayerBtn" then child:Destroy() end end
        for i, p in pairs(list) do
            local pb = UI:AddButton(parent, "👤 " .. p.Name, function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    Utils:SafeTeleport(p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                end
            end)
            pb.Name = "PlayerBtn"
            pb.Position = UDim2.new(0.05, 0, 0.3 + i * 0.08, 0)
        end
    end)
end

return TeleportHub