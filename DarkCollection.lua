--[[
    ██████╗  █████╗ ██████╗ ██╗  ██╗     ██████╗ ██████╗ ██╗     ██╗     ███████╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗
    ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝    ██╔════╝██╔═══██╗██║     ██║     ██╔════╝██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
    ██║  ██║███████║██████╔╝█████╔╝     ██║     ██║   ██║██║     ██║     █████╗  ██║        ██║   ██║██║   ██║██╔██╗ ██║
    ██║  ██║██╔══██║██╔══██╗██╔═██╗     ██║     ██║   ██║██║     ██║     ██╔══╝  ██║        ██║   ██║██║   ██║██║╚██╗██║
    ██████╔╝██║  ██║██║  ██║██║  ██╗    ╚██████╗╚██████╔╝███████╗███████╗███████╗╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║
    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝     ╚═════╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

    ============================================================================
    DARK COLLECTION — GRAY ELEGANT UI LIBRARY  •  v1.1.0
    Dashboard / UserPanel template  •  Gray + Black  •  Elegant UX
    Layout: TopBar + TopNav (horizontal icon pills, wheel-scroll) + Pages
            + Footer with player chip in the bottom-left corner.
    Themes: Default (gray) | Orange (claude) | Blood | Blue | White —
            switch live:  Library:SetTheme("Orange")  (or Window:SetTheme)
            or tap a theme button in the auto Settings tab.
    ============================================================================
    EVERYTHING IS NAMED so anyone can edit it in Explorer:
      DC_ScreenGui / DC_Backdrop / DC_Main / DC_TopBar / DC_TopNav / DC_Pages
      DC_Footer / DC_PlayerPanel / DC_PlayerAvatar / DC_FooterInfo
      DC_TabButton_<TabName> / DC_TabIcon_<TabName> / DC_Page_<TabName>
      DC_Section_<Name> / DC_Button_<Name> / DC_Toggle_<Name>
      DC_Slider_<Name> / DC_SliderBar_<Name> / DC_SliderFill_<Name>
      DC_SliderKnob_<Name> / DC_ValueBox_<Name>
      DC_Textbox_<Name> / DC_TextboxInput_<Name>
      DC_Dropdown_<Name> / DC_Label ...

    QUICK START (put at bottom of your script):
      local Library = loadstring(game:HttpGet("YOUR_RAW_URL"))()
      -- OR: local Library = require(path.to.DarkCollection)
      local Window = Library:CreateWindow({ Name = "My Hub", Subtitle = "Gray Elegant" })
      local Home = Window:CreateTab({ Name = "Home", Icon = "⌂" }) -- icons per tab!
      local Sec = Home:CreateSection({ Name = "Main" })
      Sec:AddButton({ Name = "Hello", Callback = function() print("hi") end })
      Sec:AddToggle({ Name = "Enabled", Default = false, Flag = "Enabled",
        Callback = function(v) print(v) end })
      Sec:AddSlider({ Name = "WalkSpeed", Min = 16, Max = 200, Default = 32,
        Flag = "WalkSpeed", Callback = function(v) end })
      -- Settings tab with Save GUI is built-in via Window:CreateSettingsTab()

    EDIT THE LOOK: scroll to  ▓▓ 1. EDIT-ME THEME ▓▓  — every color/size/font there.
    ============================================================================
]]

--//========================================================================//
--//  ▓▓ 1. EDIT-ME THEME — CHANGE EVERYTHING HERE (colors, sizes, fonts)  ▓▓
--//========================================================================//

local EDIT_ME = {
    -- Window
    WindowName        = "Dark Collection",
    WindowSubtitle    = "gray elegant dashboard",
    WindowSize        = UDim2.fromOffset(860, 540),
    WindowMinSize     = Vector2.new(700, 420),

    -- Palette: gray + black elegant
    Background        = Color3.fromRGB(10, 10, 12),      -- main window
    Panel             = Color3.fromRGB(19, 19, 23),      -- topbar / topnav / footer
    Card              = Color3.fromRGB(26, 26, 31),      -- sections / cards
    CardHover         = Color3.fromRGB(32, 32, 38),
    ElementBG         = Color3.fromRGB(22, 22, 27),      -- buttons / boxes
    Stroke            = Color3.fromRGB(42, 42, 48),      -- borders
    StrokeSoft        = Color3.fromRGB(32, 32, 38),
    Text              = Color3.fromRGB(235, 235, 238),   -- primary text
    Muted             = Color3.fromRGB(154, 154, 163),   -- secondary text
    Faint             = Color3.fromRGB(110, 110, 119),   -- tiny labels
    Accent            = Color3.fromRGB(217, 217, 222),   -- light gray accent (slider fill, active)
    AccentDim         = Color3.fromRGB(120, 120, 130),
    AccentText        = Color3.fromRGB(12, 12, 14),      -- text ON accent (dark on light gray)
    Success           = Color3.fromRGB(74, 222, 128),
    Danger            = Color3.fromRGB(248, 113, 113),
    ToggleOff         = Color3.fromRGB(48, 48, 55),
    ToggleOn          = Color3.fromRGB(205, 205, 212),   -- elegant light-gray ON state

    -- Shape
    Corner_Main       = 12,
    Corner_Card       = 10,
    Corner_Element    = 8,
    Corner_Small      = 6,
    StrokeThickness   = 1,

    -- Fonts (all Roblox-safe)
    FontTitle         = Enum.Font.GothamBold,
    FontBody          = Enum.Font.Gotham,
    FontMono          = Enum.Font.Code,

    -- Sizes
    SidebarWidth      = 200, -- (legacy, unused since top-nav — kept so old configs don't break)
    TopBarHeight      = 52,
    TopNavHeight      = 44,               -- horizontal icon nav strip under the top bar
    FooterHeight      = 70,               -- bottom strip holding the player chip
    PlayerPanelHeight = 64,
    TabHeight         = 34,
    ElementHeight     = 42,

    -- Backdrop (dark overlay behind the window)
    BackdropEnabled     = true,           -- set false for no dim, game fully visible
    BackdropTransparency = 0.30,          -- lower = darker (0 = pitch black, 1 = invisible)

    -- Tab icons (text glyphs — edit to any string you like, or pass Icon= per tab)
    TabIcons = {
        Home     = "⌂",   -- home thing
        Settings = "⚙",   -- gear thing
    },

    -- Behaviour
    ThemeName         = "Default",        -- Default | Orange | Blood | Blue | White
    TweenTime         = 0.18,
    SaveFolder        = "DarkCollection",   -- writefile folder for Save GUI
    AutoLoadConfig    = false,              -- auto-load last config on open
}

--//========================================================================//
--//  Services / locals (do not need to edit)
--//========================================================================//

local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local UserInputService   = game:GetService("UserInputService")
local HttpService        = game:GetService("HttpService")
local RunService         = game:GetService("RunService")
local Stats              = game:GetService("Stats")
local CoreGui            = game:GetService("CoreGui")
local TextService        = game:GetService("TextService")
local LocalPlayer        = Players.LocalPlayer

local Library = {
    Theme   = EDIT_ME,   -- expose so devs can do Library.Theme.Accent = ... at runtime
    Flags   = {},        -- FlagName -> current value (toggles/sliders/textboxes/dropdowns)
    _windows = {},
}

--//========================================================================//
--//  ▓▓ 2. THEMES — Default (gray) | Orange (claude) | Blood | Blue | White
--//  Every theme must define the same color keys. Switch live via:
--//    Library:SetTheme("Orange")  or  Window:SetTheme("Blood")
--//========================================================================//

Library.Themes = {
    Default = {
        Background  = Color3.fromRGB(10, 10, 12),
        Panel       = Color3.fromRGB(19, 19, 23),
        Card        = Color3.fromRGB(26, 26, 31),
        CardHover   = Color3.fromRGB(32, 32, 38),
        ElementBG   = Color3.fromRGB(22, 22, 27),
        Stroke      = Color3.fromRGB(42, 42, 48),
        StrokeSoft  = Color3.fromRGB(32, 32, 38),
        Text        = Color3.fromRGB(235, 235, 238),
        Muted       = Color3.fromRGB(154, 154, 163),
        Faint       = Color3.fromRGB(110, 110, 119),
        Accent      = Color3.fromRGB(217, 217, 222),
        AccentDim   = Color3.fromRGB(120, 120, 130),
        AccentText  = Color3.fromRGB(12, 12, 14),
        Success     = Color3.fromRGB(74, 222, 128),
        Danger      = Color3.fromRGB(248, 113, 113),
        ToggleOff   = Color3.fromRGB(48, 48, 55),
        ToggleOn    = Color3.fromRGB(205, 205, 212),
    },
    Orange = { -- claude-like warm orange
        Background  = Color3.fromRGB(26, 20, 15),
        Panel       = Color3.fromRGB(33, 26, 19),
        Card        = Color3.fromRGB(41, 32, 24),
        CardHover   = Color3.fromRGB(50, 39, 29),
        ElementBG   = Color3.fromRGB(36, 28, 21),
        Stroke      = Color3.fromRGB(70, 52, 36),
        StrokeSoft  = Color3.fromRGB(55, 42, 30),
        Text        = Color3.fromRGB(245, 235, 225),
        Muted       = Color3.fromRGB(195, 168, 145),
        Faint       = Color3.fromRGB(145, 122, 102),
        Accent      = Color3.fromRGB(217, 119, 87),
        AccentDim   = Color3.fromRGB(150, 92, 70),
        AccentText  = Color3.fromRGB(22, 12, 7),
        Success     = Color3.fromRGB(120, 210, 140),
        Danger      = Color3.fromRGB(240, 120, 110),
        ToggleOff   = Color3.fromRGB(62, 48, 38),
        ToggleOn    = Color3.fromRGB(217, 119, 87),
    },
    Blood = { -- blood red
        Background  = Color3.fromRGB(14, 8, 9),
        Panel       = Color3.fromRGB(22, 12, 13),
        Card        = Color3.fromRGB(30, 16, 18),
        CardHover   = Color3.fromRGB(39, 21, 23),
        ElementBG   = Color3.fromRGB(26, 14, 15),
        Stroke      = Color3.fromRGB(72, 28, 31),
        StrokeSoft  = Color3.fromRGB(56, 22, 25),
        Text        = Color3.fromRGB(245, 230, 230),
        Muted       = Color3.fromRGB(200, 160, 160),
        Faint       = Color3.fromRGB(150, 115, 116),
        Accent      = Color3.fromRGB(210, 40, 50),
        AccentDim   = Color3.fromRGB(145, 62, 66),
        AccentText  = Color3.fromRGB(18, 5, 6),
        Success     = Color3.fromRGB(120, 210, 140),
        Danger      = Color3.fromRGB(255, 90, 95),
        ToggleOff   = Color3.fromRGB(56, 25, 27),
        ToggleOn    = Color3.fromRGB(210, 40, 50),
    },
    Blue = { -- plain blue
        Background  = Color3.fromRGB(10, 13, 20),
        Panel       = Color3.fromRGB(15, 20, 30),
        Card        = Color3.fromRGB(20, 27, 40),
        CardHover   = Color3.fromRGB(27, 35, 51),
        ElementBG   = Color3.fromRGB(17, 23, 35),
        Stroke      = Color3.fromRGB(42, 62, 98),
        StrokeSoft  = Color3.fromRGB(33, 49, 80),
        Text        = Color3.fromRGB(232, 238, 248),
        Muted       = Color3.fromRGB(150, 170, 200),
        Faint       = Color3.fromRGB(110, 130, 165),
        Accent      = Color3.fromRGB(80, 150, 255),
        AccentDim   = Color3.fromRGB(92, 122, 172),
        AccentText  = Color3.fromRGB(8, 12, 22),
        Success     = Color3.fromRGB(74, 222, 150),
        Danger      = Color3.fromRGB(248, 120, 120),
        ToggleOff   = Color3.fromRGB(36, 51, 77),
        ToggleOn    = Color3.fromRGB(80, 150, 255),
    },
    White = { -- light mode
        Background  = Color3.fromRGB(228, 230, 235),
        Panel       = Color3.fromRGB(242, 243, 247),
        Card        = Color3.fromRGB(255, 255, 255),
        CardHover   = Color3.fromRGB(238, 240, 244),
        ElementBG   = Color3.fromRGB(244, 245, 249),
        Stroke      = Color3.fromRGB(205, 210, 218),
        StrokeSoft  = Color3.fromRGB(218, 222, 229),
        Text        = Color3.fromRGB(20, 22, 28),
        Muted       = Color3.fromRGB(100, 108, 120),
        Faint       = Color3.fromRGB(142, 150, 162),
        Accent      = Color3.fromRGB(35, 38, 48),
        AccentDim   = Color3.fromRGB(130, 136, 150),
        AccentText  = Color3.fromRGB(255, 255, 255),
        Success     = Color3.fromRGB(22, 160, 90),
        Danger      = Color3.fromRGB(210, 60, 60),
        ToggleOff   = Color3.fromRGB(200, 205, 215),
        ToggleOn    = Color3.fromRGB(35, 38, 48),
    },
}
Library.ThemeOrder = { "Default", "Orange", "Blood", "Blue", "White" }

-- Remap every already-created element from the old palette to the new one,
-- then point EDIT_ME at the new palette so new elements match too.
function Library:SetTheme(name)
    local theme = self.Themes[name]
    if not theme then
        warn("[DarkCollection] Unknown theme '" .. tostring(name) .. "'. Use: Default, Orange, Blood, Blue, White.")
        return false
    end
    local swaps = {}
    for key, newColor in pairs(theme) do
        local oldColor = EDIT_ME[key]
        if typeof(oldColor) == "Color3" and oldColor ~= newColor then
            swaps[key] = { old = oldColor, new = newColor }
        end
        EDIT_ME[key] = newColor
    end
    EDIT_ME.ThemeName = name

    local guis = {}
    pcall(function()
        if typeof(gethui) == "function" then
            local h = gethui()
            local g = h and h:FindFirstChild("DC_ScreenGui")
            if g then table.insert(guis, g) end
        end
    end)
    pcall(function()
        local g = CoreGui:FindFirstChild("DC_ScreenGui")
        if g then table.insert(guis, g) end
    end)
    if LocalPlayer then
        pcall(function()
            local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local g = pg and pg:FindFirstChild("DC_ScreenGui")
            if g then table.insert(guis, g) end
        end)
    end

    local props = { "BackgroundColor3", "TextColor3", "ImageColor3",
        "ScrollBarImageColor3", "PlaceholderColor3" }
    for _, gui in ipairs(guis) do
        for _, d in ipairs(gui:GetDescendants()) do
            for _, prop in ipairs(props) do
                local ok, cur = pcall(function() return d[prop] end)
                if ok and typeof(cur) == "Color3" then
                    for _, s in pairs(swaps) do
                        if cur == s.old then
                            pcall(function() d[prop] = s.new end)
                            break
                        end
                    end
                end
            end
            if d:IsA("UIStroke") then
                local cur = d.Color
                for _, s in pairs(swaps) do
                    if cur == s.old then
                        pcall(function() d.Color = s.new end)
                        break
                    end
                end
            end
            if d.Name == "DC_FooterInfo" and d:IsA("TextLabel") then
                d.Text = "Theme: " .. name .. "  •  Dark Collection v1.1"
            end
        end
    end
    print("[DarkCollection] Theme -> " .. name)
    return true
end

-- If the dev set EDIT_ME.ThemeName to something else before load,
-- point EDIT_ME at that palette now (before any window is built).
do
    local startTheme = Library.Themes[EDIT_ME.ThemeName]
    if startTheme then
        for key, c in pairs(startTheme) do EDIT_ME[key] = c end
    else
        EDIT_ME.ThemeName = "Default"
    end
end

local function TW(obj, props, time)
    time = time or EDIT_ME.TweenTime
    local info = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tw = TweenService:Create(obj, info, props)
    tw:Play()
    return tw
end

local function Corner(parent, radius, name)
    local c = Instance.new("UICorner")
    c.Name = name or "DC_Corner"
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent
    return c
end

local function Stroke(parent, color, thickness, transparency, name)
    local s = Instance.new("UIStroke")
    s.Name = name or "DC_Stroke"
    s.Color = color or EDIT_ME.Stroke
    s.Thickness = thickness or EDIT_ME.StrokeThickness
    s.Transparency = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function Padding(parent, l, t, r, b, name)
    local p = Instance.new("UIPadding")
    p.Name = name or "DC_Padding"
    p.PaddingLeft = UDim.new(0, l or 10)
    p.PaddingTop = UDim.new(0, t or 8)
    p.PaddingRight = UDim.new(0, r or 10)
    p.PaddingBottom = UDim.new(0, b or 8)
    p.Parent = parent
    return p
end

local function Label(parent, name, text, size, color, font, align)
    local l = Instance.new("TextLabel")
    l.Name = name
    l.Text = text
    l.Font = font or EDIT_ME.FontBody
    l.TextSize = size or 13
    l.TextColor3 = color or EDIT_ME.Text
    l.BackgroundTransparency = 1
    l.TextXAlignment = align or Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.TextTruncate = Enum.TextTruncate.AtEnd
    l.Parent = parent
    return l
end

local function canWrite()
    return (typeof(writefile) == "function") and (typeof(readfile) == "function") and (typeof(isfile) == "function")
end

local function ensureFolder()
    if typeof(makefolder) == "function" and typeof(isfolder) == "function" then
        pcall(function()
            if not isfolder(EDIT_ME.SaveFolder) then makefolder(EDIT_ME.SaveFolder) end
        end)
    end
end

--//========================================================================//
--//  Notifications (named: DC_Notifs / DC_Notif_<title>)
--//========================================================================//

function Library:Notify(opts)
    opts = opts or {}
    local title = opts.Title or "Dark Collection"
    local text  = opts.Text or opts.Description or ""
    local dur   = opts.Duration or 3

    -- find the live GUI wherever it was parented (hui / CoreGui / PlayerGui)
    local holder
    pcall(function()
        if typeof(gethui) == "function" then
            local h = gethui()
            local g = h and h:FindFirstChild("DC_ScreenGui")
            holder = g and g:FindFirstChild("DC_Notifs", true)
        end
    end)
    if not holder then
        pcall(function()
            local g = CoreGui:FindFirstChild("DC_ScreenGui")
            holder = g and g:FindFirstChild("DC_Notifs", true)
        end)
    end
    if not holder and LocalPlayer then
        pcall(function()
            local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local g = pg and pg:FindFirstChild("DC_ScreenGui")
            holder = g and g:FindFirstChild("DC_Notifs", true)
        end)
    end
    if not holder then return end

    local frame = Instance.new("Frame")
    frame.Name = "DC_Notif_" .. tostring(title):gsub("%W", "")
    frame.Size = UDim2.new(1, 0, 0, 56)
    frame.BackgroundColor3 = EDIT_ME.Card
    frame.BorderSizePixel = 0
    frame.Parent = holder
    Corner(frame, EDIT_ME.Corner_Element, "DC_NotifCorner")
    Stroke(frame, EDIT_ME.Stroke, 1, 0, "DC_NotifStroke")
    Padding(frame, 12, 8, 12, 8, "DC_NotifPadding")

    local bar = Instance.new("Frame")
    bar.Name = "DC_NotifBar"
    bar.Size = UDim2.new(0, 3, 1, -16)
    bar.Position = UDim2.new(0, 0, 0, 8)
    bar.BackgroundColor3 = EDIT_ME.Accent
    bar.BorderSizePixel = 0
    bar.Parent = frame
    Corner(bar, 99, "DC_NotifBarCorner")

    local titleLabel = Label(frame, "DC_NotifTitle", title, 13, EDIT_ME.Text, EDIT_ME.FontTitle)
    -- (manual layout to keep it simple & named)
    titleLabel.Size = UDim2.new(1, -16, 0, 18)
    titleLabel.Position = UDim2.new(0, 12, 0, 6)
    local body = Label(frame, "DC_NotifText", text, 12, EDIT_ME.Muted, EDIT_ME.FontBody)
    body.Size = UDim2.new(1, -16, 0, 18)
    body.Position = UDim2.new(0, 12, 0, 26)
    body.TextWrapped = true

    frame.BackgroundTransparency = 1
    TW(frame, { BackgroundTransparency = 0 }, 0.2)
    task.delay(dur, function()
        if frame and frame.Parent then
            local t = TW(frame, { BackgroundTransparency = 1 }, 0.3)
            t.Completed:Wait()
            frame:Destroy()
        end
    end)
end

--//========================================================================//
--//  CreateWindow — Dashboard shell: TopBar + TopNav + Pages + Footer
--//========================================================================//

function Library:_getUIParent()
    -- Executor-safe parent: gethui > get_hidden_gui > CoreGui > PlayerGui
    -- (gethui/get_hidden_gui render on top and survive the CoreGui protection)
    if typeof(gethui) == "function" then
        local ok, h = pcall(gethui)
        if ok and h then return h end
    end
    if typeof(get_hidden_gui) == "function" then
        local ok, h = pcall(get_hidden_gui)
        if ok and h then return h end
    end
    local okCore, coreGui = pcall(function() return CoreGui end)
    if okCore and coreGui then
        -- test write access; if protected this pcall fails and we fall through
        local probe = Instance.new("ScreenGui")
        probe.Name = "DC_Probe"
        local canWrite = pcall(function() probe.Parent = coreGui end)
        pcall(function() probe:Destroy() end)
        if canWrite then return coreGui end
    end
    -- PlayerGui fallback (works in Studio + normal LocalScripts).
    -- Wait briefly in case the executor ran before PlayerGui replicated.
    local plr = LocalPlayer or Players.LocalPlayer
    if plr then
        local pg = plr:FindFirstChildOfClass("PlayerGui")
        if not pg then
            pcall(function() pg = plr:WaitForChild("PlayerGui", 5) end)
        end
        if pg then return pg end
    end
    return nil
end

function Library:CreateWindow(opts)
    opts = opts or {}
    local winName = opts.Name or EDIT_ME.WindowName
    local winSub  = opts.Subtitle or EDIT_ME.WindowSubtitle

    local parent = self:_getUIParent()

    -- Clean old copies everywhere (CoreGui AND PlayerGui AND hui)
    pcall(function()
        local o = CoreGui:FindFirstChild("DC_ScreenGui")
        if o then o:Destroy() end
    end)
    if LocalPlayer then
        pcall(function()
            local pg0 = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local o2 = pg0 and pg0:FindFirstChild("DC_ScreenGui")
            if o2 then o2:Destroy() end
        end)
    end
    if parent then
        pcall(function()
            local o3 = parent:FindFirstChild("DC_ScreenGui")
            if o3 and o3 ~= parent then o3:Destroy() end
        end)
    end

    if not parent then
        warn("[DarkCollection] No UI parent found (no gethui/CoreGui/PlayerGui). "
            .. "Are you running on the Server? This library needs a LocalScript / executor.")
        return nil
    end

    ensureFolder()

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DC_ScreenGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true -- cover EVERYTHING incl. the topbar strip
    ScreenGui.DisplayOrder = 999
    ScreenGui.Enabled = true
    ScreenGui.Parent = parent

    -- Fullscreen dark backdrop (visual dim only, clicks pass through)
    local Backdrop = Instance.new("Frame")
    Backdrop.Name = "DC_Backdrop"
    Backdrop.Size = UDim2.fromScale(1, 1)
    Backdrop.Position = UDim2.fromScale(0, 0)
    Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Backdrop.BackgroundTransparency = EDIT_ME.BackdropTransparency
    Backdrop.BorderSizePixel = 0
    Backdrop.Active = false
    Backdrop.ZIndex = 0
    Backdrop.Visible = EDIT_ME.BackdropEnabled ~= false
    Backdrop.Parent = ScreenGui

    -- Main window
    local Main = Instance.new("Frame")
    Main.Name = "DC_Main"
    Main.Size = opts.Size or EDIT_ME.WindowSize
    Main.Position = UDim2.fromScale(0.5, 0.5)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = EDIT_ME.Background
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.ZIndex = 5
    Main.Parent = ScreenGui
    Corner(Main, EDIT_ME.Corner_Main, "DC_MainCorner")
    Stroke(Main, EDIT_ME.Stroke, 1, 0, "DC_MainStroke")

    -- TopBar ---------------------------------------------------------------
    local TopBar = Instance.new("Frame")
    TopBar.Name = "DC_TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, EDIT_ME.TopBarHeight)
    TopBar.BackgroundColor3 = EDIT_ME.Panel
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Main
    do
        local c = Corner(TopBar, EDIT_ME.Corner_Main, "DC_TopBarCorner")
        -- square off bottom of topbar so it blends into body
        local fix = Instance.new("Frame")
        fix.Name = "DC_TopBarFix"
        fix.Size = UDim2.new(1, 0, 0, EDIT_ME.Corner_Main)
        fix.Position = UDim2.new(0, 0, 1, -EDIT_ME.Corner_Main)
        fix.BackgroundColor3 = EDIT_ME.Panel
        fix.BorderSizePixel = 0
        fix.Parent = TopBar
    end
    local TopStroke = Instance.new("Frame")
    TopStroke.Name = "DC_TopBarDivider"
    TopStroke.Size = UDim2.new(1, 0, 0, 1)
    TopStroke.Position = UDim2.new(0, 0, 1, -1)
    TopStroke.BackgroundColor3 = EDIT_ME.Stroke
    TopStroke.BorderSizePixel = 0
    TopStroke.Parent = TopBar

    local Dot = Instance.new("Frame")
    Dot.Name = "DC_StatusDot"
    Dot.Size = UDim2.fromOffset(8, 8)
    Dot.Position = UDim2.new(0, 16, 0.5, -4)
    Dot.BackgroundColor3 = EDIT_ME.Success
    Dot.BorderSizePixel = 0
    Dot.Parent = TopBar
    Corner(Dot, 99, "DC_StatusDotCorner")

    local Title = Label(TopBar, "DC_WindowTitle", winName, 15, EDIT_ME.Text, EDIT_ME.FontTitle)
    Title.Size = UDim2.new(0, 300, 0, 20)
    Title.Position = UDim2.new(0, 32, 0, 7)

    local Sub = Label(TopBar, "DC_WindowSubtitle", winSub, 11, EDIT_ME.Muted, EDIT_ME.FontBody)
    Sub.Size = UDim2.new(0, 300, 0, 14)
    Sub.Position = UDim2.new(0, 32, 0, 27)

    local function topBtn(name, text, xOff)
        local b = Instance.new("TextButton")
        b.Name = name
        b.Text = text
        b.Font = EDIT_ME.FontBody
        b.TextSize = 14
        b.TextColor3 = EDIT_ME.Muted
        b.Size = UDim2.fromOffset(32, 28)
        b.Position = UDim2.new(1, xOff, 0.5, -14)
        b.BackgroundColor3 = EDIT_ME.ElementBG
        b.BorderSizePixel = 0
        b.AutoButtonColor = true
        b.Parent = TopBar
        Corner(b, EDIT_ME.Corner_Small, name .. "Corner")
        Stroke(b, EDIT_ME.StrokeSoft, 1, 0, name .. "Stroke")
        return b
    end
    local MinBtn = topBtn("DC_MinimizeBtn", "–", -76)
    local CloseBtn = topBtn("DC_CloseBtn", "✕", -36)
    CloseBtn.TextColor3 = EDIT_ME.Danger

    -- TopNav: ONE navigation spot (horizontal, icons).
    -- Scroll your mouse wheel over it: down = slide right, up = slide left.
    local TopNav = Instance.new("Frame")
    TopNav.Name = "DC_TopNav"
    TopNav.Size = UDim2.new(1, 0, 0, EDIT_ME.TopNavHeight)
    TopNav.Position = UDim2.new(0, 0, 0, EDIT_ME.TopBarHeight)
    TopNav.BackgroundColor3 = EDIT_ME.Panel
    TopNav.BorderSizePixel = 0
    TopNav.Parent = Main
    do
        -- square off the top corners so it blends under the TopBar
        local fix = Instance.new("Frame")
        fix.Name = "DC_TopNavFix"
        fix.Size = UDim2.new(1, 0, 0, EDIT_ME.Corner_Main)
        fix.BackgroundColor3 = EDIT_ME.Panel
        fix.BorderSizePixel = 0
        fix.Parent = TopNav
    end

    local TabHolder = Instance.new("ScrollingFrame")
    TabHolder.Name = "DC_TabHolder"
    TabHolder.Size = UDim2.new(1, -16, 1, -10)
    TabHolder.Position = UDim2.new(0, 8, 0, 5)
    TabHolder.BackgroundTransparency = 1
    TabHolder.BorderSizePixel = 0
    TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabHolder.AutomaticCanvasSize = Enum.AutomaticSize.X
    TabHolder.ScrollingDirection = Enum.ScrollingDirection.X
    TabHolder.ScrollBarThickness = 0
    TabHolder.VerticalScrollBarInset = Enum.ScrollBarInset.None
    TabHolder.Parent = TopNav
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Name = "DC_TabLayout"
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 6)
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    TabLayout.Parent = TabHolder

    local NavDivider = Instance.new("Frame")
    NavDivider.Name = "DC_TopNavDivider"
    NavDivider.Size = UDim2.new(1, 0, 0, 1)
    NavDivider.Position = UDim2.new(0, 0, 1, -1)
    NavDivider.BackgroundColor3 = EDIT_ME.Stroke
    NavDivider.BorderSizePixel = 0
    NavDivider.Parent = TopNav

    -- wheel over the nav = horizontal slide (down -> right, up -> left)
    do
        local hovering = false
        TabHolder.MouseEnter:Connect(function() hovering = true end)
        TabHolder.MouseLeave:Connect(function() hovering = false end)
        UserInputService.InputChanged:Connect(function(input)
            if hovering and TabHolder.Parent then
                if input.UserInputType == Enum.UserInputType.MouseWheelForward then
                    TabHolder.CanvasPosition = Vector2.new(TabHolder.CanvasPosition.X - 64, 0)
                elseif input.UserInputType == Enum.UserInputType.MouseWheelBackward then
                    TabHolder.CanvasPosition = Vector2.new(TabHolder.CanvasPosition.X + 64, 0)
                end
            end
        end)
    end

    -- Footer: bottom strip, player chip lives in the left corner ------------
    local Footer = Instance.new("Frame")
    Footer.Name = "DC_Footer"
    Footer.Size = UDim2.new(1, 0, 0, EDIT_ME.FooterHeight)
    Footer.Position = UDim2.new(0, 0, 1, -EDIT_ME.FooterHeight)
    Footer.BackgroundColor3 = EDIT_ME.Panel
    Footer.BorderSizePixel = 0
    Footer.Parent = Main
    Corner(Footer, EDIT_ME.Corner_Main, "DC_FooterCorner")
    do
        -- keep the TOP edge square (blends into content), round the BOTTOM
        local fix = Instance.new("Frame")
        fix.Name = "DC_FooterFix"
        fix.Size = UDim2.new(1, 0, 0, EDIT_ME.Corner_Main)
        fix.Position = UDim2.new(0, 0, 0, 0)
        fix.BackgroundColor3 = EDIT_ME.Panel
        fix.BorderSizePixel = 0
        fix.Parent = Footer
    end
    local FootDivider = Instance.new("Frame")
    FootDivider.Name = "DC_FooterDivider"
    FootDivider.Size = UDim2.new(1, 0, 0, 1)
    FootDivider.BackgroundColor3 = EDIT_ME.Stroke
    FootDivider.BorderSizePixel = 0
    FootDivider.Parent = Footer

    local FootInfo = Label(Footer, "DC_FooterInfo", "Theme: " .. EDIT_ME.ThemeName .. "  •  Dark Collection v1.1",
        10, EDIT_ME.Faint, EDIT_ME.FontBody, Enum.TextXAlignment.Right)
    FootInfo.Size = UDim2.new(0, 260, 0, 16)
    FootInfo.Position = UDim2.new(1, -272, 1, -24)

    -- ★ PlayerPanel bottom-LEFT corner: PFP + DisplayName + @username + extras
    local PlayerPanel = Instance.new("Frame")
    PlayerPanel.Name = "DC_PlayerPanel"
    PlayerPanel.Size = UDim2.new(0, 280, 1, -12)
    PlayerPanel.Position = UDim2.new(0, 8, 0, 6)
    PlayerPanel.BackgroundColor3 = EDIT_ME.Card
    PlayerPanel.BorderSizePixel = 0
    PlayerPanel.Parent = Footer
    Corner(PlayerPanel, EDIT_ME.Corner_Card, "DC_PlayerPanelCorner")
    Stroke(PlayerPanel, EDIT_ME.Stroke, 1, 0, "DC_PlayerPanelStroke")
    Padding(PlayerPanel, 8, 8, 8, 8, "DC_PlayerPanelPadding")

    local Avatar = Instance.new("ImageLabel")
    Avatar.Name = "DC_PlayerAvatar"
    Avatar.Size = UDim2.fromOffset(40, 40)
    Avatar.Position = UDim2.new(0, 0, 0, 0)
    Avatar.BackgroundColor3 = EDIT_ME.ElementBG
    Avatar.BorderSizePixel = 0
    Avatar.Image = "" -- filled below
    Avatar.Parent = PlayerPanel
    Corner(Avatar, 99, "DC_PlayerAvatarCorner")
    Stroke(Avatar, EDIT_ME.Stroke, 1, 0, "DC_PlayerAvatarStroke")

    local DisplayName = Label(PlayerPanel, "DC_PlayerDisplayName", LocalPlayer and LocalPlayer.DisplayName or "Guest", 13, EDIT_ME.Text, EDIT_ME.FontTitle)
    DisplayName.Size = UDim2.new(1, -56, 0, 17)
    DisplayName.Position = UDim2.new(0, 48, 0, 1)

    local Username = Label(PlayerPanel, "DC_PlayerUsername", LocalPlayer and ("@" .. LocalPlayer.Name) or "@guest", 11, EDIT_ME.Muted, EDIT_ME.FontBody)
    Username.Size = UDim2.new(1, -56, 0, 14)
    Username.Position = UDim2.new(0, 48, 0, 18)

    local Extra = Label(PlayerPanel, "DC_PlayerExtra", "60 FPS • 48ms", 10, EDIT_ME.Faint, Enum.Font.Code)
    Extra.Name = "DC_PlayerExtra"
    Extra.Size = UDim2.new(1, -56, 0, 13)
    Extra.Position = UDim2.new(0, 48, 0, 33)

    -- load real Roblox PFP
    task.spawn(function()
        if LocalPlayer then
            local ok, thumb = pcall(function()
                return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
            end)
            if ok and thumb and Avatar and Avatar.Parent then
                Avatar.Image = thumb
            end
        end
    end)

    -- live FPS / Ping line under player name (few things)
    task.spawn(function()
        local frames, last = 0, tick()
        local fps = 60
        RunService.RenderStepped:Connect(function()
            frames += 1
            local now = tick()
            if now - last >= 0.5 then
                fps = math.floor(frames / (now - last) + 0.5)
                frames, last = 0, now
            end
        end)
        while Extra and Extra.Parent do
            local ping = "--"
            pcall(function()
                local s = Stats.Network.ServerStatsItem
                    and Stats.Network.ServerStatsItem["Data Ping"]
                if s then ping = string.format("%dms", math.floor(s:GetValue() + 0.5)) end
            end)
            Extra.Text = string.format("%d FPS • %s", fps, tostring(ping))
            task.wait(1)
        end
    end)

    -- Pages (content between TopNav and Footer) ------------------------------
    local pagesTop = EDIT_ME.TopBarHeight + EDIT_ME.TopNavHeight + 10
    local pagesBottom = EDIT_ME.FooterHeight + 10
    local Pages = Instance.new("Frame")
    Pages.Name = "DC_Pages"
    Pages.Size = UDim2.new(1, -24, 1, -(pagesTop + pagesBottom))
    Pages.Position = UDim2.new(0, 12, 0, pagesTop)
    Pages.BackgroundTransparency = 1
    Pages.Parent = Main

    -- Notifications holder
    local Notifs = Instance.new("Frame")
    Notifs.Name = "DC_Notifs"
    Notifs.Size = UDim2.new(0, 260, 1, -20)
    Notifs.Position = UDim2.new(1, -270, 0, 10)
    Notifs.AnchorPoint = Vector2.new(0, 0)
    Notifs.BackgroundTransparency = 1
    Notifs.ZIndex = 50
    Notifs.Parent = ScreenGui
    local NLayout = Instance.new("UIListLayout")
    NLayout.Name = "DC_NotifsLayout"
    NLayout.Padding = UDim.new(0, 8)
    NLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    NLayout.Parent = Notifs

    -- Dragging (TopBar)
    do
        local dragging, dragStart, startPos = false, nil, nil
        TopBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging, dragStart, startPos = true, input.Position, Main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local d = input.Position - dragStart
                Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)
    end

    -- Window object ---------------------------------------------------------
    local Window = {
        _gui = ScreenGui, _main = Main, _pages = Pages,
        _tabHolder = TabHolder, _tabs = {}, _active = nil,
        Name = winName,
    }

    function Window:SetTheme(name)
        local ok = Library:SetTheme(name)
        if ok then self:Notify({ Title = "Theme", Text = "Switched to " .. tostring(name) }) end
        return ok
    end

    function Window:Notify(o) return Library:Notify(o) end

    local collapsed = false
    local oldSize = Main.Size
    MinBtn.MouseButton1Click:Connect(function()
        collapsed = not collapsed
        MinBtn.Text = collapsed and "+" or "–"
        TW(Main, { Size = collapsed and UDim2.new(oldSize.X.Scale, oldSize.X.Offset, 0, EDIT_ME.TopBarHeight) or oldSize }, 0.22)
        Pages.Visible = not collapsed
        TopNav.Visible = not collapsed
        Footer.Visible = not collapsed
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    function Window:ToggleUI()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
    function Window:Destroy()
        if ScreenGui then ScreenGui:Destroy() end
    end

    -- Config Save / Load (Save GUI) ----------------------------------------
    function Window:GetConfig()
        local out = {}
        for k, v in pairs(Library.Flags) do
            if type(v) == "table" then
                local c = {}
                for k2, v2 in pairs(v) do c[k2] = v2 end
                out[k] = c
            else
                out[k] = v
            end
        end
        return out
    end
    function Window:ApplyConfig(data)
        if type(data) ~= "table" then return end
        for flag, val in pairs(data) do
            Library.Flags[flag] = val
            local setter = Library["_setter_" .. tostring(flag)]
            if typeof(setter) == "function" then
                pcall(setter, val)
            end
        end
    end
    function Window:SaveGUI(fileName)
        fileName = fileName or "default"
        local data = HttpService:JSONEncode(self:GetConfig())
        if canWrite() then
            ensureFolder()
            pcall(writefile, EDIT_ME.SaveFolder .. "/" .. tostring(fileName) .. ".json", data)
            self:Notify({ Title = "Save GUI", Text = "Saved '" .. tostring(fileName) .. "'" })
        else
            -- Studio fallback: stash in attribute
            pcall(function() ScreenGui:SetAttribute("DC_Config_" .. fileName, data) end)
            self:Notify({ Title = "Save GUI", Text = "(Studio) config cached in memory" })
        end
    end
    function Window:LoadGUI(fileName)
        fileName = fileName or "default"
        local raw
        if canWrite() then
            pcall(function() raw = readfile(EDIT_ME.SaveFolder .. "/" .. tostring(fileName) .. ".json") end)
        else
            pcall(function() raw = ScreenGui:GetAttribute("DC_Config_" .. fileName) end)
        end
        if raw then
            local ok, data = pcall(HttpService.JSONDecode, HttpService, raw)
            if ok and type(data) == "table" then
                self:ApplyConfig(data)
                self:Notify({ Title = "Save GUI", Text = "Loaded '" .. tostring(fileName) .. "'" })
                return true
            end
        end
        self:Notify({ Title = "Save GUI", Text = "No save found: '" .. tostring(fileName) .. "'" })
        return false
    end

    function Window:CreateSettingsTab()
        local tab = self:CreateTab({ Name = "Settings", Icon = EDIT_ME.TabIcons.Settings })
        local themeSec = tab:CreateSection({ Name = "Themes" })
        themeSec:AddLabel({ Text = "Pick a look. Applies instantly to the whole UI." })
        for _, themeName in ipairs(Library.ThemeOrder) do
            themeSec:AddButton({ Name = themeName, Callback = function()
                self:SetTheme(themeName)
            end })
        end
        local sec = tab:CreateSection({ Name = "Save GUI" })
        sec:AddTextbox({ Name = "Config Name", Default = "default", Flag = "__DC_ConfigName", Callback = function() end })
        sec:AddButton({ Name = "Save GUI", Callback = function()
            self:SaveGUI(Library.Flags["__DC_ConfigName"] or "default")
        end })
        sec:AddButton({ Name = "Load GUI", Callback = function()
            self:LoadGUI(Library.Flags["__DC_ConfigName"] or "default")
        end })
        sec:AddToggle({ Name = "Show Notifications", Default = true, Flag = "__DC_Notifs", Callback = function() end })
        local sec2 = tab:CreateSection({ Name = "Interface" })
        sec2:AddButton({ Name = "Unload GUI", Callback = function() self:Destroy() end })
        sec2:AddButton({ Name = "Toggle UI (keybind: RightShift)", Callback = function() self:ToggleUI() end })
        UserInputService.InputBegan:Connect(function(i, g)
            if not g and i.KeyCode == Enum.KeyCode.RightShift then self:ToggleUI() end
        end)
        return tab
    end

    -- Tabs (top-nav pills with icons) ---------------------------------------
    function Window:CreateTab(opts)
        opts = opts or {}
        local tabName = opts.Name or ("Tab" .. (#self._tabs + 1))
        local safe = tabName:gsub("%W", "")
        -- icon: per-tab override > EDIT_ME.TabIcons lookup > first letter
        local icon = opts.Icon or (EDIT_ME.TabIcons and EDIT_ME.TabIcons[tabName])
            or tabName:sub(1, 1):upper()

        -- measure the name so the pill fits (icon badge + padding)
        local textW = 60
        pcall(function()
            textW = TextService:GetTextSize(tabName, 13, EDIT_ME.FontBody,
                Vector2.new(1000, 20)).X
        end)
        local pillW = math.floor(textW + 62)

        local Btn = Instance.new("TextButton")
        Btn.Name = "DC_TabButton_" .. safe
        Btn.Size = UDim2.new(0, pillW, 0, EDIT_ME.TabHeight)
        Btn.BackgroundColor3 = EDIT_ME.Panel
        Btn.BackgroundTransparency = 1 -- inactive = ghost; active = filled card
        Btn.BorderSizePixel = 0
        Btn.AutoButtonColor = false
        Btn.Text = ""
        Btn.LayoutOrder = #self._tabs + 1
        Btn.Parent = self._tabHolder
        Corner(Btn, EDIT_ME.Corner_Element, "DC_TabBtnCorner")
        local BtnStroke = Stroke(Btn, EDIT_ME.Stroke, 1, 1, "DC_TabBtnStroke")

        -- icon badge (the "home thing" / "gear thing")
        local Badge = Instance.new("Frame")
        Badge.Name = "DC_TabIcon_" .. safe
        Badge.Size = UDim2.fromOffset(22, 22)
        Badge.Position = UDim2.new(0, 6, 0.5, -11)
        Badge.BackgroundColor3 = EDIT_ME.ElementBG
        Badge.BorderSizePixel = 0
        Badge.Parent = Btn
        Corner(Badge, EDIT_ME.Corner_Small, "DC_TabIconCorner")
        local BadgeLabel = Label(Badge, "DC_TabIconLabel", icon, 13, EDIT_ME.Muted, EDIT_ME.FontTitle, Enum.TextXAlignment.Center)
        BadgeLabel.Size = UDim2.fromScale(1, 1)

        local T = Label(Btn, "DC_TabLabel", tabName, 13, EDIT_ME.Muted, EDIT_ME.FontBody)
        T.Size = UDim2.new(1, -36, 1, 0)
        T.Position = UDim2.new(0, 32, 0, 0)

        -- underline indicator for the active pill
        local Ind = Instance.new("Frame")
        Ind.Name = "DC_TabIndicator"
        Ind.AnchorPoint = Vector2.new(0.5, 1)
        Ind.Size = UDim2.new(1, -20, 0, 2)
        Ind.Position = UDim2.new(0.5, 0, 1, -3)
        Ind.BackgroundColor3 = EDIT_ME.Accent
        Ind.BackgroundTransparency = 1
        Ind.BorderSizePixel = 0
        Ind.Parent = Btn
        Corner(Ind, 99, "DC_TabIndicatorCorner")

        Btn.MouseEnter:Connect(function()
            if self._active and self._active._btn == Btn then return end
            TW(Btn, { BackgroundTransparency = 0.55 }, 0.12)
        end)
        Btn.MouseLeave:Connect(function()
            if self._active and self._active._btn == Btn then return end
            TW(Btn, { BackgroundTransparency = 1 }, 0.12)
        end)

        local Page = Instance.new("ScrollingFrame")
        Page.Name = "DC_Page_" .. tabName:gsub("%W", "")
        Page.Size = UDim2.fromScale(1, 1)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 3
        Page.ScrollBarImageColor3 = EDIT_ME.Stroke
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.Visible = false
        Page.Parent = self._pages
        local PLayout = Instance.new("UIListLayout")
        PLayout.Name = "DC_PageLayout"
        PLayout.Padding = UDim.new(0, 10)
        PLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PLayout.Parent = Page

        local Tab = { Name = tabName, _btn = Btn, _page = Page, _window = self }

        function Tab:CreateSection(opts2)
            opts2 = opts2 or {}
            local secName = opts2.Name or "Section"

            local Sec = Instance.new("Frame")
            Sec.Name = "DC_Section_" .. secName:gsub("%W", "")
            Sec.Size = UDim2.new(1, 0, 0, 40)
            Sec.BackgroundColor3 = EDIT_ME.Card
            Sec.BorderSizePixel = 0
            Sec.AutomaticSize = Enum.AutomaticSize.Y
            Sec.Parent = Page
            Corner(Sec, EDIT_ME.Corner_Card, "DC_SectionCorner")
            Stroke(Sec, EDIT_ME.Stroke, 1, 0, "DC_SectionStroke")
            Padding(Sec, 12, 10, 12, 12, "DC_SectionPadding")

            local STitle = Label(Sec, "DC_SectionTitle", string.upper(secName), 11, EDIT_ME.Faint, EDIT_ME.FontTitle)
            STitle.Size = UDim2.new(1, 0, 0, 16)

            local List = Instance.new("Frame")
            List.Name = "DC_SectionList"
            List.Position = UDim2.new(0, 0, 0, 22)
            List.Size = UDim2.new(1, 0, 0, 0)
            List.AutomaticSize = Enum.AutomaticSize.Y
            List.BackgroundTransparency = 1
            List.Parent = Sec
            local LL = Instance.new("UIListLayout")
            LL.Name = "DC_SectionListLayout"
            LL.Padding = UDim.new(0, 6)
            LL.SortOrder = Enum.SortOrder.LayoutOrder
            LL.Parent = List

            local Section = { Name = secName, _frame = Sec, _list = List }

            -- shared row builder: card row with left labels + right control area
            local function rowBase(elName, title, desc)
                local Row = Instance.new("Frame")
                Row.Name = elName
                Row.Size = UDim2.new(1, 0, 0, (desc and desc ~= "") and 52 or EDIT_ME.ElementHeight)
                Row.BackgroundColor3 = EDIT_ME.ElementBG
                Row.BorderSizePixel = 0
                Row.Parent = List
                Corner(Row, EDIT_ME.Corner_Element, elName .. "Corner")
                Stroke(Row, EDIT_ME.StrokeSoft, 1, 0, elName .. "Stroke")
                Padding(Row, 10, 6, 10, 6, elName .. "Padding")

                local L1 = Label(Row, elName .. "_Title", title, 13, EDIT_ME.Text, EDIT_ME.FontBody)
                L1.Size = UDim2.new(0.55, 0, 0, 18)
                L1.Position = UDim2.new(0, 0, 0, desc ~= "" and 2 or 6)
                local L2
                if desc and desc ~= "" then
                    L2 = Label(Row, elName .. "_Desc", desc, 11, EDIT_ME.Muted, EDIT_ME.FontBody)
                    L2.Size = UDim2.new(0.55, 0, 0, 14)
                    L2.Position = UDim2.new(0, 0, 0, 22)
                end
                local Right = Instance.new("Frame")
                Right.Name = elName .. "_Right"
                Right.Size = UDim2.new(0.45, -4, 1, 0)
                Right.Position = UDim2.new(0.55, 4, 0, 0)
                Right.BackgroundTransparency = 1
                Right.Parent = Row
                return Row, Right
            end

            --== LABEL / PARAGRAPH ==========================================--
            function Section:AddLabel(o)
                o = typeof(o) == "string" and { Text = o } or (o or {})
                local l = Label(List, "DC_Label", o.Text or "Label", 12, EDIT_ME.Muted, EDIT_ME.FontBody)
                l.Size = UDim2.new(1, 0, 0, 18)
                l.TextWrapped = true
                return l
            end
            function Section:AddParagraph(o)
                o = o or {}
                local box = Instance.new("Frame")
                box.Name = "DC_Paragraph"
                box.Size = UDim2.new(1, 0, 0, 60)
                box.AutomaticSize = Enum.AutomaticSize.Y
                box.BackgroundColor3 = EDIT_ME.ElementBG
                box.BorderSizePixel = 0
                box.Parent = List
                Corner(box, EDIT_ME.Corner_Element, "DC_ParagraphCorner")
                Stroke(box, EDIT_ME.StrokeSoft, 1, 0, "DC_ParagraphStroke")
                Padding(box, 10, 8, 10, 8, "DC_ParagraphPadding")
                local t = Label(box, "DC_ParagraphTitle", o.Title or "Card", 13, EDIT_ME.Text, EDIT_ME.FontTitle)
                t.Size = UDim2.new(1, 0, 0, 18)
                local b = Label(box, "DC_ParagraphBody", o.Text or "", 12, EDIT_ME.Muted, EDIT_ME.FontBody)
                b.Size = UDim2.new(1, 0, 0, 14)
                b.AutomaticSize = Enum.AutomaticSize.Y
                b.Position = UDim2.new(0, 0, 0, 20)
                b.TextWrapped = true
                return box
            end

            --== BUTTON =====================================================--
            function Section:AddButton(o)
                o = o or {}
                local name = o.Name or "Button"
                local safe = name:gsub("%W", "")
                local Row, Right = rowBase("DC_Button_" .. safe, name, o.Desc or o.Description or "")

                local B = Instance.new("TextButton")
                B.Name = "DC_ButtonBtn_" .. safe
                B.Size = UDim2.fromScale(1, 1)
                B.BackgroundColor3 = EDIT_ME.CardHover
                B.BorderSizePixel = 0
                B.Font = EDIT_ME.FontBody
                B.TextSize = 12
                B.TextColor3 = EDIT_ME.Text
                B.Text = o.Text or name
                B.AutoButtonColor = true
                B.Parent = Right
                Corner(B, EDIT_ME.Corner_Small, "DC_ButtonBtnCorner")
                Stroke(B, EDIT_ME.Stroke, 1, 0, "DC_ButtonBtnStroke")
                B.MouseButton1Click:Connect(function()
                    TW(B, { BackgroundColor3 = EDIT_ME.Accent }, 0.08)
                    task.delay(0.1, function() TW(B, { BackgroundColor3 = EDIT_ME.CardHover }, 0.15) end)
                    pcall(o.Callback or function() end)
                end)
                return B
            end

            --== TOGGLE =====================================================--
            function Section:AddToggle(o)
                o = o or {}
                local name = o.Name or "Toggle"
                local safe = name:gsub("%W", "")
                local flag = o.Flag or name
                local state = (o.Default == true)
                Library.Flags[flag] = state

                local Row, Right = rowBase("DC_Toggle_" .. safe, name, o.Desc or "")
                local Track = Instance.new("TextButton")
                Track.Name = "DC_ToggleTrack_" .. safe
                Track.Size = UDim2.fromOffset(44, 22)
                Track.Position = UDim2.new(1, -44, 0.5, -11)
                Track.BackgroundColor3 = state and EDIT_ME.ToggleOn or EDIT_ME.ToggleOff
                Track.BorderSizePixel = 0
                Track.Text = ""
                Track.AutoButtonColor = false
                Track.Parent = Right
                Corner(Track, 99, "DC_ToggleTrackCorner")
                Stroke(Track, EDIT_ME.Stroke, 1, 0, "DC_ToggleTrackStroke")

                local Knob = Instance.new("Frame")
                Knob.Name = "DC_ToggleKnob_" .. safe
                Knob.Size = UDim2.fromOffset(16, 16)
                Knob.Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                Knob.BackgroundColor3 = state and EDIT_ME.AccentText or EDIT_ME.Muted
                Knob.BorderSizePixel = 0
                Knob.Parent = Track
                Corner(Knob, 99, "DC_ToggleKnobCorner")

                local function apply(v, silent)
                    state = (v == true)
                    Library.Flags[flag] = state
                    TW(Track, { BackgroundColor3 = state and EDIT_ME.ToggleOn or EDIT_ME.ToggleOff }, 0.15)
                    TW(Knob, {
                        Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
                        BackgroundColor3 = state and EDIT_ME.AccentText or EDIT_ME.Muted,
                    }, 0.15)
                    if not silent then pcall(o.Callback or function() end, state) end
                end
                Library["_setter_" .. flag] = apply
                Track.MouseButton1Click:Connect(function() apply(not state) end)
                if state and o.Callback then task.spawn(o.Callback, true) end
                return { Set = apply, _track = Track }
            end

            --== SLIDER + TEXTBOX (two-way synced) ==========================--
            function Section:AddSlider(o)
                o = o or {}
                local name = o.Name or "Slider"
                local safe = name:gsub("%W", "")
                local flag = o.Flag or name
                local min = o.Min or 0
                local max = o.Max or 100
                local inc = o.Increment or o.Step or 1
                local suffix = o.ValueSuffix or o.Suffix or ""
                local val = math.clamp(o.Default or min, min, max)
                Library.Flags[flag] = val

                local Row = Instance.new("Frame")
                Row.Name = "DC_Slider_" .. safe
                Row.Size = UDim2.new(1, 0, 0, 64)
                Row.BackgroundColor3 = EDIT_ME.ElementBG
                Row.BorderSizePixel = 0
                Row.Parent = List
                Corner(Row, EDIT_ME.Corner_Element, "DC_SliderCorner")
                Stroke(Row, EDIT_ME.StrokeSoft, 1, 0, "DC_SliderStroke")
                Padding(Row, 10, 8, 10, 8, "DC_SliderPadding")

                local Top = Instance.new("Frame")
                Top.Name = "DC_SliderTop_" .. safe
                Top.Size = UDim2.new(1, 0, 0, 20)
                Top.BackgroundTransparency = 1
                Top.Parent = Row
                local L = Label(Top, "DC_SliderTitle_" .. safe, name, 13, EDIT_ME.Text, EDIT_ME.FontBody)
                L.Size = UDim2.new(1, -70, 1, 0)

                -- ValueBox TextBox on the right: typing a number moves the slider
                local ValueBox = Instance.new("TextBox")
                ValueBox.Name = "DC_ValueBox_" .. safe
                ValueBox.Size = UDim2.fromOffset(60, 20)
                ValueBox.Position = UDim2.new(1, -60, 0, 0)
                ValueBox.BackgroundColor3 = EDIT_ME.Card
                ValueBox.BorderSizePixel = 0
                ValueBox.Font = Enum.Font.Code
                ValueBox.TextSize = 12
                ValueBox.TextColor3 = EDIT_ME.Text
                ValueBox.PlaceholderColor3 = EDIT_ME.Faint
                ValueBox.Text = tostring(val) .. suffix
                ValueBox.ClearTextOnFocus = true
                ValueBox.Parent = Top
                Corner(ValueBox, EDIT_ME.Corner_Small, "DC_ValueBoxCorner")
                Stroke(ValueBox, EDIT_ME.Stroke, 1, 0, "DC_ValueBoxStroke")

                local Bar = Instance.new("TextButton")
                Bar.Name = "DC_SliderBar_" .. safe
                Bar.Size = UDim2.new(1, 0, 0, 8)
                Bar.Position = UDim2.new(0, 0, 0, 34)
                Bar.BackgroundColor3 = EDIT_ME.ToggleOff
                Bar.BorderSizePixel = 0
                Bar.Text = ""
                Bar.AutoButtonColor = false
                Bar.Parent = Row
                Corner(Bar, 99, "DC_SliderBarCorner")

                local Fill = Instance.new("Frame")
                Fill.Name = "DC_SliderFill_" .. safe
                Fill.Size = UDim2.fromScale((val - min) / math.max(1e-6, (max - min)), 1)
                Fill.BackgroundColor3 = EDIT_ME.Accent
                Fill.BorderSizePixel = 0
                Fill.Parent = Bar
                Corner(Fill, 99, "DC_SliderFillCorner")

                local Knob = Instance.new("Frame")
                Knob.Name = "DC_SliderKnob_" .. safe
                Knob.Size = UDim2.fromOffset(14, 14)
                Knob.AnchorPoint = Vector2.new(0.5, 0.5)
                Knob.Position = UDim2.new((val - min) / math.max(1e-6, (max - min)), 0, 0.5, 0)
                Knob.BackgroundColor3 = EDIT_ME.Text
                Knob.BorderSizePixel = 0
                Knob.Parent = Bar
                Corner(Knob, 99, "DC_SliderKnobCorner")
                Stroke(Knob, EDIT_ME.Stroke, 1, 0, "DC_SliderKnobStroke")

                local dragging = false
                local function render(v)
                    local pct = (v - min) / math.max(1e-6, (max - min))
                    Fill.Size = UDim2.fromScale(pct, 1)
                    Knob.Position = UDim2.new(pct, 0, 0.5, 0)
                    if ValueBox:IsFocused() == false then
                        ValueBox.Text = tostring(v) .. suffix
                    end
                end
                local function apply(v, silent)
                    v = math.clamp(v, min, max)
                    if inc > 0 then v = math.floor((v - min) / inc + 0.5) * inc + min end
                    -- trim float noise
                    v = math.floor(v * 100 + 0.5) / 100
                    Library.Flags[flag] = v
                    render(v)
                    if not silent then pcall(o.Callback or function() end, v) end
                end
                Library["_setter_" .. flag] = apply

                local function fromInput(input)
                    local abs = Bar.AbsolutePosition.X
                    local w = math.max(1, Bar.AbsoluteSize.X)
                    local pct = math.clamp((input.Position.X - abs) / w, 0, 1)
                    apply(min + pct * (max - min))
                end
                Bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        fromInput(input)
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        fromInput(input)
                    end
                end)
                -- TextBox -> Slider sync
                ValueBox.FocusLost:Connect(function(enter)
                    local num = tonumber((ValueBox.Text or ""):gsub("[^%d%.%-]", ""))
                    if num then apply(num) else ValueBox.Text = tostring(Library.Flags[flag]) .. suffix end
                end)

                render(val)
                if o.Callback and o.Default ~= nil then task.spawn(o.Callback, val) end
                return { Set = apply, _box = ValueBox }
            end

            --== TEXTBOX ====================================================--
            function Section:AddTextbox(o)
                o = o or {}
                local name = o.Name or "Textbox"
                local safe = name:gsub("%W", "")
                local flag = o.Flag or name
                Library.Flags[flag] = o.Default or ""

                local Row, Right = rowBase("DC_Textbox_" .. safe, name, o.Desc or "")
                local Input = Instance.new("TextBox")
                Input.Name = "DC_TextboxInput_" .. safe
                Input.Size = UDim2.fromScale(1, 1)
                Input.BackgroundColor3 = EDIT_ME.Card
                Input.BorderSizePixel = 0
                Input.Font = EDIT_ME.FontBody
                Input.TextSize = 12
                Input.TextColor3 = EDIT_ME.Text
                Input.PlaceholderColor3 = EDIT_ME.Faint
                Input.PlaceholderText = o.Placeholder or ("Type " .. string.lower(name) .. "...")
                Input.Text = tostring(o.Default or "")
                Input.ClearTextOnFocus = false
                Input.Parent = Right
                Corner(Input, EDIT_ME.Corner_Small, "DC_TextboxInputCorner")
                Stroke(Input, EDIT_ME.Stroke, 1, 0, "DC_TextboxInputStroke")
                Padding(Input, 8, 0, 8, 0, "DC_TextboxInputPadding")
                Input.TextXAlignment = Enum.TextXAlignment.Left

                local function apply(v, silent)
                    v = tostring(v or "")
                    if o.NumbersOnly and v ~= "" and tonumber(v) == nil then return end
                    Library.Flags[flag] = v
                    if Input.Text ~= v then Input.Text = v end
                    if not silent then pcall(o.Callback or function() end, v) end
                end
                Library["_setter_" .. flag] = apply
                Input.FocusLost:Connect(function()
                    local v = Input.Text
                    if o.NumbersOnly and v ~= "" and tonumber(v) == nil then
                        Input.Text = tostring(Library.Flags[flag] or "")
                        return
                    end
                    Library.Flags[flag] = v
                    pcall(o.Callback or function() end, v)
                end)
                return { Set = apply, _box = Input }
            end

            --== DROPDOWN ===================================================--
            function Section:AddDropdown(o)
                o = o or {}
                local name = o.Name or "Dropdown"
                local safe = name:gsub("%W", "")
                local flag = o.Flag or name
                local options = o.Options or { "Option 1", "Option 2" }
                local current = o.Default or options[1]
                Library.Flags[flag] = current

                local Row = Instance.new("Frame")
                Row.Name = "DC_Dropdown_" .. safe
                Row.Size = UDim2.new(1, 0, 0, EDIT_ME.ElementHeight)
                Row.BackgroundColor3 = EDIT_ME.ElementBG
                Row.BorderSizePixel = 0
                Row.ClipsDescendants = false
                Row.Parent = List
                Row.ZIndex = 5
                Corner(Row, EDIT_ME.Corner_Element, "DC_DropdownCorner")
                Stroke(Row, EDIT_ME.StrokeSoft, 1, 0, "DC_DropdownStroke")
                Padding(Row, 10, 6, 10, 6, "DC_DropdownPadding")
                local L = Label(Row, "DC_DropdownTitle_" .. safe, name, 13, EDIT_ME.Text, EDIT_ME.FontBody)
                L.Size = UDim2.new(0.5, 0, 1, 0)

                local Btn = Instance.new("TextButton")
                Btn.Name = "DC_DropdownBtn_" .. safe
                Btn.Size = UDim2.new(0.5, -4, 1, 0)
                Btn.Position = UDim2.new(0.5, 4, 0, 0)
                Btn.BackgroundColor3 = EDIT_ME.Card
                Btn.BorderSizePixel = 0
                Btn.Font = EDIT_ME.FontBody
                Btn.TextSize = 12
                Btn.TextColor3 = EDIT_ME.Text
                Btn.Text = "  " .. tostring(current) .. "   ▾"
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                Btn.Parent = Row
                Corner(Btn, EDIT_ME.Corner_Small, "DC_DropdownBtnCorner")
                Stroke(Btn, EDIT_ME.Stroke, 1, 0, "DC_DropdownBtnStroke")

                local Drop = Instance.new("Frame")
                Drop.Name = "DC_DropdownList_" .. safe
                Drop.Size = UDim2.new(0.5, -4, 0, math.min(#options, 5) * 28 + 8)
                Drop.Position = UDim2.new(0.5, 4, 1, 4)
                Drop.BackgroundColor3 = EDIT_ME.Card
                Drop.BorderSizePixel = 0
                Drop.Visible = false
                Drop.Parent = Row
                Drop.ZIndex = 10
                Corner(Drop, EDIT_ME.Corner_Small, "DC_DropdownListCorner")
                Stroke(Drop, EDIT_ME.Stroke, 1, 0, "DC_DropdownListStroke")
                Padding(Drop, 4, 4, 4, 4, "DC_DropdownListPadding")
                local DL = Instance.new("UIListLayout")
                DL.Name = "DC_DropdownLayout_" .. safe
                DL.Padding = UDim.new(0, 2)
                DL.Parent = Drop

                local open = false
                local function setOpen(v)
                    open = v
                    Drop.Visible = v
                    Btn.Text = "  " .. tostring(current) .. (v and "   ▴" or "   ▾")
                end
                Btn.MouseButton1Click:Connect(function() setOpen(not open) end)

                local function apply(v, silent)
                    current = v
                    Library.Flags[flag] = v
                    Btn.Text = "  " .. tostring(v) .. "   ▾"
                    Drop.Visible = false
                    open = false
                    if not silent then pcall(o.Callback or function() end, v) end
                end
                Library["_setter_" .. flag] = apply

                for _, opt in ipairs(options) do
                    local ob = Instance.new("TextButton")
                    ob.Name = "DC_DropdownOpt_" .. tostring(opt):gsub("%W", "")
                    ob.Size = UDim2.new(1, 0, 0, 26)
                    ob.BackgroundColor3 = EDIT_ME.Card
                    ob.BorderSizePixel = 0
                    ob.Font = EDIT_ME.FontBody
                    ob.TextSize = 12
                    ob.TextColor3 = EDIT_ME.Muted
                    ob.Text = "  " .. tostring(opt)
                    ob.TextXAlignment = Enum.TextXAlignment.Left
                    ob.Parent = Drop
                    ob.ZIndex = 11
                    Corner(ob, EDIT_ME.Corner_Small, "DC_DropdownOptCorner")
                    ob.MouseEnter:Connect(function() ob.BackgroundColor3 = EDIT_ME.CardHover; ob.TextColor3 = EDIT_ME.Text end)
                    ob.MouseLeave:Connect(function() ob.BackgroundColor3 = EDIT_ME.Card; ob.TextColor3 = EDIT_ME.Muted end)
                    ob.MouseButton1Click:Connect(function() apply(opt) end)
                end
                return { Set = apply }
            end

            --== KEYBIND (simple) ===========================================--
            function Section:AddKeybind(o)
                o = o or {}
                local name = o.Name or "Keybind"
                local safe = name:gsub("%W", "")
                local current = o.Default or Enum.KeyCode.RightShift
                local Row, Right = rowBase("DC_Keybind_" .. safe, name, o.Desc or "")
                local B = Instance.new("TextButton")
                B.Name = "DC_KeybindBtn_" .. safe
                B.Size = UDim2.new(0, 110, 1, 0)
                B.Position = UDim2.new(1, -110, 0, 0)
                B.BackgroundColor3 = EDIT_ME.Card
                B.BorderSizePixel = 0
                B.Font = Enum.Font.Code
                B.TextSize = 12
                B.TextColor3 = EDIT_ME.Text
                B.Text = current.Name
                B.Parent = Right
                Corner(B, EDIT_ME.Corner_Small, "DC_KeybindBtnCorner")
                Stroke(B, EDIT_ME.Stroke, 1, 0, "DC_KeybindBtnStroke")
                local listening = false
                B.MouseButton1Click:Connect(function()
                    listening = true
                    B.Text = "..."
                end)
                UserInputService.InputBegan:Connect(function(input, g)
                    if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                        listening = false
                        current = input.KeyCode
                        B.Text = current.Name
                        pcall(o.Callback or function() end, current)
                    elseif not listening and not g and input.KeyCode == current then
                        pcall(o.Callback or function() end, current)
                    end
                end)
                return B
            end

            return Section
        end

        table.insert(self._tabs, Tab)

        Btn.MouseButton1Click:Connect(function()
            self:_select(Tab)
        end)

        if #self._tabs == 1 then
            self:_select(Tab)
        end
        return Tab
    end

    function Window:_select(tab)
        self._active = tab
        for _, t in ipairs(self._tabs) do
            local active = (t == tab)
            t._page.Visible = active
            TW(t._btn, {
                BackgroundColor3 = active and EDIT_ME.Card or EDIT_ME.Panel,
                BackgroundTransparency = active and 0 or 1,
            }, 0.15)
            local stroke = t._btn:FindFirstChild("DC_TabBtnStroke")
            if stroke then stroke.Transparency = active and 0 or 1 end
            local lbl = t._btn:FindFirstChild("DC_TabLabel")
            if lbl then lbl.TextColor3 = active and EDIT_ME.Text or EDIT_ME.Muted end
            local ind = t._btn:FindFirstChild("DC_TabIndicator")
            if ind then ind.BackgroundTransparency = active and 0 or 1 end
            -- icon badge: find by prefix (name includes tab safe name)
            for _, ch in ipairs(t._btn:GetChildren()) do
                if ch:IsA("Frame") and ch.Name:find("DC_TabIcon_") then
                    TW(ch, { BackgroundColor3 = active and EDIT_ME.Accent or EDIT_ME.ElementBG }, 0.15)
                    local bl = ch:FindFirstChild("DC_TabIconLabel")
                    if bl then bl.TextColor3 = active and EDIT_ME.AccentText or EDIT_ME.Muted end
                end
            end
        end
        -- keep the active pill in view when wheel/tap-jumping
        pcall(function()
            local holder = self._tabHolder
            local x = tab._btn.Position.X.Offset - 10
            if x < holder.CanvasPosition.X or x > holder.CanvasPosition.X + holder.AbsoluteWindowSize.X - tab._btn.AbsoluteSize.X then
                holder.CanvasPosition = Vector2.new(math.max(0, x), 0)
            end
        end)
    end

    table.insert(Library._windows, Window)

    if EDIT_ME.AutoLoadConfig then
        task.spawn(function()
            task.wait(0.5)
            pcall(function() Window:LoadGUI("default") end)
        end)
    end

    print("[DarkCollection] UI created: '" .. tostring(winName) .. "' parented to "
        .. tostring(ScreenGui.Parent and ScreenGui.Parent:GetFullName()))
    print("[DarkCollection] Hint: call Window:CreateTab({Name='Home'}) then Tab:CreateSection({Name='Main'}) to add content.")

    return Window
end

-- One-call demo dashboard. Use when you just want *something* on screen:
--   local Library = loadstring(game:HttpGet("URL"))()
--   Library:ShowDemo()
function Library:ShowDemo()
    local Window = self:CreateWindow({ Name = EDIT_ME.WindowName, Subtitle = EDIT_ME.WindowSubtitle })
    if not Window then return nil end
    local Home = Window:CreateTab({ Name = "Home", Icon = "⌂" })
    local Sec = Home:CreateSection({ Name = "Main" })
    Sec:AddParagraph({ Title = "Dark Collection working",
        Text = "Top nav pills slide with the mouse wheel. Player chip is bottom-left." })
    Sec:AddButton({ Name = "Test Notification", Desc = "click me",
        Callback = function() Window:Notify({ Title = "Hello", Text = "UI works." }) end })
    Sec:AddToggle({ Name = "Demo Toggle", Default = false, Flag = "DemoToggle",
        Callback = function(v) print("DemoToggle:", v) end })
    Sec:AddSlider({ Name = "WalkSpeed", Min = 16, Max = 200, Default = 32, Increment = 1,
        Flag = "WalkSpeed",
        Callback = function(v)
            local ch = LocalPlayer and LocalPlayer.Character
            local h = ch and ch:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = v end
        end })
    Sec:AddTextbox({ Name = "Config Test", Placeholder = "type here...", Flag = "DemoText",
        Callback = function(v) print(v) end })
    Window:CreateSettingsTab()
    Window:Notify({ Title = "Dark Collection", Text = "Demo loaded." })
    return Window
end

pcall(function() _G.DC_Library = Library end)
print("[DarkCollection] Library loaded. Next: local W = Library:CreateWindow(...) or Library:ShowDemo()")

return Library

--//========================================================================//
--//  ★ EXAMPLE TEMPLATE — copy/paste below into your own script ★
--//========================================================================//
--[[
local Library = require(path.to.DarkCollection) -- or loadstring(...)

local Window = Library:CreateWindow({ Name = "My Dashboard", Subtitle = "gray elegant" })

-- HOME (top-nav icon pill)
local Home = Window:CreateTab({ Name = "Home", Icon = "⌂" })
local Main = Home:CreateSection({ Name = "Main" })
Main:AddParagraph({ Title = "Welcome", Text = "Gray + black elegant user panel." })
Main:AddButton({ Name = "Say Hello", Desc = "A simple button", Callback = function()
    Window:Notify({ Title = "Hello", Text = "Button pressed" })
end })
Main:AddToggle({ Name = "Auto Farm", Desc = "Loops your farm", Default = false, Flag = "AutoFarm",
    Callback = function(v) print("AutoFarm:", v) end })
Main:AddSlider({ Name = "WalkSpeed", Desc = "Slider + TextBox synced", Min = 16, Max = 200,
    Default = 32, Increment = 1, ValueSuffix = "", Flag = "WalkSpeed",
    Callback = function(v)
        local p = game.Players.LocalPlayer.Character
            and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if p then p.WalkSpeed = v end
    end })
Main:AddTextbox({ Name = "Target Player", Placeholder = "Enter username...", Flag = "Target",
    Callback = function(v) print("Target:", v) end })
Main:AddDropdown({ Name = "Mode", Options = { "Legit", "Rage", "Silent" }, Default = "Legit",
    Flag = "Mode", Callback = function(v) print(v) end })

-- SETTINGS (Save GUI, unload, keybinds)
Window:CreateSettingsTab()
]]
