local AutoStats = { running = false, ratios = { Melee=25, Defense=25, Sword=25, Gun=12.5, Fruit=12.5 } }
local Utils = _G.Utils
local LP = _G.LP

function AutoStats:Allocate()
    local points = LP.Data.StatsPoints.Value
    if points <= 0 then return end
    for stat, ratio in pairs(self.ratios) do
        local add = math.floor(points * ratio / 100)
        if add > 0 then
            Utils:AddStat(stat, add)
            task.wait(0.1)
        end
    end
end

function AutoStats:Start()
    if self.running then return end
    self.running = true
    task.spawn(function()
        while self.running do
            pcall(function() self:Allocate() end)
            task.wait(1)
        end
    end)
end

function AutoStats:Stop()
    self.running = false
end

function AutoStats:CreateSliders(parent)
    local pos = 0.45
    for stat, ratio in pairs(self.ratios) do
        local slider = UI:AddSlider(parent, stat .. " (" .. ratio .. "%)", 0, 100, ratio, function(v)
            self.ratios[stat] = v
        end)
        pos = pos + 0.1
    end
end

return AutoStats