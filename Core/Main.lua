-- ============================================
-- DOEAK HUB - MAIN (v2.0)
-- ============================================
local BASE_URL = "https://raw.githubusercontent.com/phat85638-blip/DOEAK_Hub/main/"

-- Safe loader
local function safeLoad(url)
    local s, r = pcall(function() return loadstring(game:HttpGet(url))() end)
    if not s then warn("⚠️ Load fail: " .. url .. "\n" .. tostring(r)) return nil end
    return r
end

-- Core
local KeySystem = safeLoad(BASE_URL .. "Core/KeySystem.lua?v=2")
local Utils = safeLoad(BASE_URL .. "Core/Utils.lua?v=2")
local UI = safeLoad(BASE_URL .. "Core/UI.lua?v=2")
if not UI then error("❌ Không load được UI") end

-- Modules
local AutoLevel = safeLoad(BASE_URL .. "Modules/Farm/AutoLevel.lua?v=2")
local AutoMastery = safeLoad(BASE_URL .. "Modules/Farm/AutoMastery.lua?v=2")
local AutoBoss = safeLoad(BASE_URL .. "Modules/Farm/AutoBoss.lua?v=2")
local SeaEvent = safeLoad(BASE_URL .. "Modules/Sea/SeaEvent.lua?v=2")
local Sniper = safeLoad(BASE_URL .. "Modules/Fruit/Sniper.lua?v=2")
local FastAttack = safeLoad(BASE_URL .. "Modules/Combat/FastAttack.lua?v=2")
local TeleportHub = safeLoad(BASE_URL .. "Modules/Teleport/TeleportHub.lua?v=2")
local ESPCore = safeLoad(BASE_URL .. "Modules/ESP/ESPCore.lua?v=2")
local AutoStats = safeLoad(BASE_URL .. "Modules/Progression/AutoStats.lua?v=2")
local AntiAFK = safeLoad(BASE_URL .. "Modules/Utility/AntiAFK.lua?v=2")

local Main = {}

function Main:Init()
    UI:Init()
    
    local farmTab = UI:CreateTab("⚔️ Farm")
    local seaTab = UI:CreateTab("🌊 Sea")
    local fruitTab = UI:CreateTab("🍎 Fruit")
    local espTab = UI:CreateTab("👁️ ESP")
    local teleTab = UI:CreateTab("🚀 Teleport")
    local setTab = UI:CreateTab("⚙️ Settings")

    -- Farm
    UI:AddLabel(farmTab, "Auto Farm", Color3.fromRGB(255,200,100))
    if AutoLevel then
        UI:AddToggle(farmTab, "Auto Level (Nearest)", false, function(s) if s then AutoLevel:Start() else AutoLevel:Stop() end end)
        UI:AddToggle(farmTab, "No Quest (Farm only)", false, function(s) AutoLevel.noQuest = s end)
    end
    if AutoMastery then
        UI:AddToggle(farmTab, "Auto Mastery", false, function(s) if s then AutoMastery:Start() else AutoMastery:Stop() end end)
        UI:AddDropdown(farmTab, "Mastery Weapon", {"Melee","Sword","Gun","Fruit"}, function(v) if AutoMastery then AutoMastery.weapon = v end end)
    end
    if AutoBoss then
        UI:AddToggle(farmTab, "Auto Boss", false, function(s) if s then AutoBoss:Start() else AutoBoss:Stop() end end)
        UI:AddDropdown(farmTab, "Select Boss", {"Saber Expert","Greybeard","Ice Admiral","Diamond","Fishman Lord","Warden","Chief Warden","Darkbeard","Order","Rumble","Frostbite","Cryo","Pirate King"}, function(v) if AutoBoss then AutoBoss.bossName = v end end)
    end
    if FastAttack then
        UI:AddLabel(farmTab, "Fast Attack", Color3.fromRGB(200,200,200))
        UI:AddSlider(farmTab, "Speed (1-20)", 1, 20, 10, function(v) FastAttack:SetSpeed(v) end)
        UI:AddToggle(farmTab, "Fast Attack ON/OFF", false, function(s) if s then FastAttack:Start() else FastAttack:Stop() end end)
    end

    -- Sea
    UI:AddLabel(seaTab, "Sea Events", Color3.fromRGB(100,200,255))
    if SeaEvent then
        UI:AddToggle(seaTab, "Auto Sea Event", false, function(s) if s then SeaEvent:Start() else SeaEvent:Stop() end end)
    end

    -- Fruit
    UI:AddLabel(fruitTab, "Fruit", Color3.fromRGB(255,100,200))
    if Sniper then
        UI:AddToggle(fruitTab, "Auto Fruit Sniper", false, function(s) if s then Sniper:Start() else Sniper:Stop() end end)
    end

    -- ESP
    UI:AddLabel(espTab, "ESP", Color3.fromRGB(100,255,100))
    if ESPCore then
        UI:AddToggle(espTab, "Player ESP", false, function(s) if s then ESPCore:Start() else ESPCore:Stop() end end)
    end

    -- Teleport
    UI:AddLabel(teleTab, "Teleport", Color3.fromRGB(255,200,100))
    if TeleportHub then
        UI:AddButton(teleTab, "🏝️ Sea 1", function() TeleportHub:To("Sea1") end)
        UI:AddButton(teleTab, "🏝️ Sea 2", function() TeleportHub:To("Sea2") end)
        UI:AddButton(teleTab, "🏝️ Sea 3", function() TeleportHub:To("Sea3") end)
        UI:AddLabel(teleTab, "Teleport to Player", Color3.fromRGB(200,200,200))
        TeleportHub:ShowPlayerList(teleTab)
    end

    -- Settings
    UI:AddLabel(setTab, "Settings", Color3.fromRGB(255,255,100))
    if AntiAFK then
        UI:AddToggle(setTab, "Anti AFK (Jump/Dash)", true, function(s) if s then AntiAFK:Start() else AntiAFK:Stop() end end)
    end
    if AutoStats then
        UI:AddToggle(setTab, "Auto Stats", false, function(s) if s then AutoStats:Start() else AutoStats:Stop() end end)
        UI:AddLabel(setTab, "Stat Ratios", Color3.fromRGB(200,200,200))
        AutoStats:CreateSliders(setTab)
    end

    UI:Notify("🐉 DOEAK Hub ready! Key: doeak_key_123")
end

pcall(function() Main:Init() end)