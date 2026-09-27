# DarkCollection-UI-Library

Gray + black elegant Roblox UI library. Dashboard / user panel template with top icon nav, live player chip, and 5 switchable themes.

## Files

- `DarkCollection.lua` — the library (load this)
- `DarkCollection_Example.lua` — example dashboard (execute this to see the UI)

## Load via URL

```lua
local Library = loadstring(game:HttpGet(
  "https://raw.githubusercontent.com/sigma494/DarkCollection-UI-Library/main/DarkCollection.lua"
))()
Library:ShowDemo()
```

## Quick start

```lua
local Window = Library:CreateWindow({ Name = "My Hub", Subtitle = "gray elegant" })

local Home = Window:CreateTab({ Name = "Home", Icon = "⌂" })
local Sec = Home:CreateSection({ Name = "Main" })

Sec:AddButton({ Name = "Hello", Callback = function()
  Window:Notify({ Title = "Hello", Text = "It works" })
end })

Sec:AddToggle({ Name = "Auto Farm", Default = false, Flag = "AutoFarm",
  Callback = function(v) print(v) end })

Sec:AddSlider({ Name = "WalkSpeed", Min = 16, Max = 200, Default = 32,
  Increment = 1, Flag = "WalkSpeed",
  Callback = function(v)
    local h = game.Players.LocalPlayer.Character
      :FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = v end
  end })

Sec:AddTextbox({ Name = "Target", Placeholder = "username...",
  Flag = "Target" })

Sec:AddDropdown({ Name = "Mode", Options = { "Legit", "Rage" },
  Default = "Legit", Flag = "Mode" })

Window:CreateSettingsTab() -- themes + Save/Load GUI
```

## Features

- Top horizontal icon nav (mouse wheel slides left/right), one nav spot
- Bottom-left player chip: Roblox PFP + DisplayName + `@username` + live FPS/ping
- Sliders two-way synced with their number boxes
- Themes: `Default` (gray), `Orange` (claude), `Blood`, `Blue`, `White`
  ```lua
  Window:SetTheme("Orange") -- or Library:SetTheme("Blood")
  ```
- Settings tab: theme buttons + Save/Load GUI (`writefile` configs)
- Every instance named `DC_*` — restyle freely in Explorer
- Executor-safe parenting (`gethui` → CoreGui → PlayerGui)

## Notes

- Executing `DarkCollection.lua` alone shows nothing (it's a library).
  Execute the example file or call `Library:ShowDemo()`.
- `RightShift` toggles the UI.
