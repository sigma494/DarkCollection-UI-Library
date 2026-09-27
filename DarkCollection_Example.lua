-- DarkCollection — RUN THIS FILE to see the UI (gray elegant dashboard)
-- IMPORTANT: executing DarkCollection.lua alone shows NOTHING (it's just a
-- library that returns a table). Execute THIS file instead.
--
-- HOW TO RUN (pick ONE):
--   1. Executor, two files: put DarkCollection.lua next to this file, then
--      execute this file. It loads the library via readfile().
--   2. Single paste: paste ALL of DarkCollection.lua first, then paste the
--      DEMO section below in the same executor tab and execute.
--   3. URL: replace URL below with your raw DarkCollection.lua link.

local Library = nil

-- strategy 1: library already loaded above in same chunk (single paste)
if typeof(_G) == "table" and _G.DC_Library then
    Library = _G.DC_Library
end

-- strategy 2: load sibling file via executor readfile()
if not Library and typeof(readfile) == "function" and typeof(loadstring) == "function" then
    local ok, src = pcall(readfile, "DarkCollection.lua")
    if not ok then
        -- maybe executor cwd differs; try the workspace folder name variant
        ok, src = pcall(readfile, "workspace/DarkCollection.lua")
    end
    if ok and src and #src > 100 then
        local fn, err = loadstring(src)
        if fn then
            local ok2, lib = pcall(fn)
            if ok2 and type(lib) == "table" then Library = lib end
        else
            warn("[DarkCollection] loadstring failed: " .. tostring(err))
        end
    end
end

-- strategy 3: URL (edit me)
if not Library then
    local URL = "https://raw.githubusercontent.com/sigma494/DarkCollection-UI-Library/main/DarkCollection.lua"
    if URL:find("http") and typeof(game.HttpGet) ~= nil then
        local ok, res = pcall(function() return game:HttpGet(URL) end)
        if ok and res and #res > 100 then
            local fn = loadstring(res)
            if fn then Library = fn() end
        end
    end
end

if not Library then
    warn("[DarkCollection] Could not find the library. "
        .. "Paste DarkCollection.lua ABOVE this code in the same tab, then execute. "
        .. "Or place DarkCollection.lua beside this file so readfile() works.")
    return
end

print("[DarkCollection] Library loaded, building demo UI...")

-- QUICK TEST: one call, always shows something ------------------------------
-- If even this shows nothing, check F9 console for the parent warning.
local Window = Library:ShowDemo()
if not Window then
    warn("[DarkCollection] ShowDemo returned nil — see warning above (likely Server-side execution). Run as LocalScript / executor.")
    return
end

-- FULL DASHBOARD (adds more tabs on top of the demo window) ------------------
-- Tabs live in ONE spot now: the top icon nav. Wheel down = slide right.
local Vis = Window:CreateTab({ Name = "Visuals", Icon = "◉" })
local VisSec = Vis:CreateSection({ Name = "ESP" })
VisSec:AddToggle({ Name = "Box ESP", Default = false, Flag = "BoxESP",
    Callback = function(v) print("BoxESP:", v) end })
VisSec:AddToggle({ Name = "Name ESP", Default = true, Flag = "NameESP",
    Callback = function(v) print("NameESP:", v) end })
VisSec:AddSlider({ Name = "JumpPower", Min = 50, Max = 300, Default = 50,
    Increment = 5, Flag = "JumpPower",
    Callback = function(v)
        local ch = game.Players.LocalPlayer.Character
        local h = ch and ch:FindFirstChildOfClass("Humanoid")
        if h then h.JumpPower = v end
    end })
VisSec:AddDropdown({ Name = "Mode", Options = { "Legit", "Rage", "Silent" },
    Default = "Legit", Flag = "Mode",
    Callback = function(v) print("Mode:", v) end })
VisSec:AddKeybind({ Name = "Toggle UI", Default = Enum.KeyCode.RightShift,
    Callback = function() Window:ToggleUI() end })

-- THEMES: Default | Orange (claude) | Blood | Blue | White -------------------
local ThemeTab = Window:CreateTab({ Name = "Style", Icon = "★" })
local ThemeSec = ThemeTab:CreateSection({ Name = "Themes" })
ThemeSec:AddLabel({ Text = "Applies instantly to the whole UI." })
for _, name in ipairs({ "Default", "Orange", "Blood", "Blue", "White" }) do
    ThemeSec:AddButton({ Name = name, Callback = function()
        Window:SetTheme(name) -- or Library:SetTheme(name)
    end })
end
-- Window:SetTheme("Orange") -- or set EDIT_ME.ThemeName before load

print("[DarkCollection] Done. Look for DC_ScreenGui under gethui/CoreGui/PlayerGui.")
