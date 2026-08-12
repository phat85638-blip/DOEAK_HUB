-- ============================================
-- DOEAK HUB - KEY SYSTEM
-- ============================================
local KeySystem = {}
local VALID_KEY = "doeak_key_123"
KeySystem.Authenticated = false
KeySystem.Attempts = 0
KeySystem.MAX_ATTEMPTS = 3

function KeySystem:CheckKey(inputKey)
    if not inputKey or inputKey == "" then
        return false, "⚠️ Nhập key!"
    end
    if self.Attempts >= self.MAX_ATTEMPTS then
        return false, "❌ Sai 3 lần, chạy lại."
    end
    if inputKey == VALID_KEY then
        self.Authenticated = true
        self.Attempts = 0
        return true, "✅ OK! Welcome!"
    else
        self.Attempts = self.Attempts + 1
        return false, "❌ Sai! Còn " .. (3 - self.Attempts) .. " lần"
    end
end

return KeySystem