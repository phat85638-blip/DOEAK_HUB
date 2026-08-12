-- ============================================
-- DOEAK HUB - UTILS
-- ============================================
local Utils = {}
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local CommF = RS:FindFirstChild("Remotes")
if CommF then CommF = CommF:FindFirstChild("CommF_") end

_G.Utils = Utils
_G.LP = LP
_G.WS = WS
_G.CommF = CommF

function Utils:FireRemote(...)
    if not CommF then return nil end
    local args = {...}
    local s, r = pcall(function() return CommF:InvokeServer(table.unpack(args)) end)
    return s and r or nil
end

function Utils:Attack(t) return self:FireRemote("Attack", t) end
function Utils:AddStat(stat, p) return self:FireRemote("AddStat", stat, p) end

function Utils:SafeTeleport(cf)
    local char = LP.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    root.CFrame = cf
    task.wait(0.1)
    return true
end

function Utils:FindNearestNPC(maxD, diff)
    local char = LP.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local lv = LP.Data.Level.Value
    maxD = maxD or 200
    diff = diff or 5
    local best, bestD = nil, math.huge
    local enemies = WS:FindFirstChild("Enemies")
    if not enemies then return nil end
    for _, e in pairs(enemies:GetChildren()) do
        if e:IsA("Model") and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
            local elv = e:FindFirstChild("Level")
            if elv and math.abs(elv.Value - lv) <= diff then
                local r = e:FindFirstChild("HumanoidRootPart")
                if r then
                    local d = (root.Position - r.Position).Magnitude
                    if d < bestD and d < maxD then best, bestD = e, d end
                end
            end
        end
    end
    return best
end

function Utils:FindSeaEvent()
    for _, obj in pairs(WS:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
            local name = obj.Name
            if name:find("SeaBeast") or name:find("Leviathan") or name:find("Ghost") or name:find("Terrorshark") then
                if obj:FindFirstChild("HumanoidRootPart") then return obj end
            end
        end
    end
    return nil
end

function Utils:GetPlayerList()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(list, p)
        end
    end
    return list
end

return Utils