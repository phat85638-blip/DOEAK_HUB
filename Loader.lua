-- ============================================
-- DOEAK HUB - LOADER (v2.0)
-- ============================================
local url = "https://raw.githubusercontent.com/phat85638-blip/DOEAK_Hub/main/Core/Main.lua?v=2"
local success, content = pcall(function()
    return game:HttpGet(url)
end)
if not success then
    error("❌ Không thể tải DOEAK Hub.\nLỗi: " .. tostring(content))
end
loadstring(content)()