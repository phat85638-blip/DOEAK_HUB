local FastAttack = { running = false, speed = 1 }
local CommF = _G.CommF
local oldInvoke = nil

function FastAttack:Start()
    if self.running or not CommF then return end
    self.running = true
    oldInvoke = CommF.InvokeServer
    CommF.InvokeServer = function(a1, a2, a3, a4, a5)
        if a1 == "Attack" and FastAttack.running then
            for _ = 1, math.floor(FastAttack.speed) do
                pcall(function() oldInvoke(a1, a2, a3, a4, a5) end)
                task.wait(0.05)
            end
            return oldInvoke(a1, a2, a3, a4, a5)
        end
        return oldInvoke(a1, a2, a3, a4, a5)
    end
end

function FastAttack:Stop()
    self.running = false
    if oldInvoke and CommF then CommF.InvokeServer = oldInvoke end
end

function FastAttack:SetSpeed(v)
    self.speed = math.max(1, math.min(20, v))
end

return FastAttack