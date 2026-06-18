-- ###################
-- ### MY PROGRAMS ###
-- ###################

local terminal = "foot"
local fileManager = "thunar"
local codeEditor = "code"
local notepad = "mousepad"
local menu = 'rofi -show drun -theme ~/.config/rofi/rofi-launcher.rasi'
local browser = "firefox"
local powermenu = "~/Scripts/Rofi/system.sh standalone"
local cliphist_menu = "~/Scripts/Rofi/cliphist.sh standalone"
local wallpaper_menu = "~/Scripts/Rofi/wallpaper.sh standalone"
local hub_configuration = "~/Scripts/Rofi/configuration.sh standalone"

local function bind(keys, dispatcher, description, opts)
  opts = opts or {}
  opts.description = description
  return hl.bind(keys, dispatcher, opts)
end

local function move_active_window_or_dispatch(direction, delta)
  return function()
    local activeWindow = hl.get_active_window()

    if activeWindow ~= nil and activeWindow.floating then
      hl.dispatch(hl.dsp.window.move({
        x = delta.x,
        y = delta.y,
        relative = true,
      }))
      return
    end

    hl.dispatch(hl.dsp.window.move({ direction = direction }))
  end
end

-- ###################
-- ### KEYBINDINGS ###
-- ###################

local mainMod = "SUPER"
local launcher = "launcher"
local utilities = "utilites"
local windowManagement = "window management"
local workspaces = "workspaces"
local hardwareControls = "hardware controls"

-- Hyprland Stuffs
bind(mainMod .. " + Q", hl.dsp.window.close(), "[" .. windowManagement .. "] close focused window")
bind(mainMod .. " + P", hl.dsp.window.float({ action = "toggle" }), "[" .. windowManagement .. "] toggle float")
bind(mainMod .. " + F", hl.dsp.window.fullscreen(), "[" .. windowManagement .. "] toggle fullscreen")
bind(mainMod .. " + S", hl.dsp.layout("togglesplit"), "[" .. windowManagement .. "] toggle split")

-- Swap Window on workspaces
bind("ALT + SPACE", hl.dsp.window.swap({ next = true }), "[" .. windowManagement .. "] swap window") -- OLD swapnext -- direction: r l u d | right,left,up,down
bind("ALT + TAB", hl.dsp.window.swap({ next = true }), "[" .. windowManagement .. "] swap window") -- OLD swapnext -- direction: r l u d | right,left,up,down
bind("CTRL + SPACE", hl.dsp.window.swap({ next = true }), "[" .. windowManagement .. "] swap window") -- OLD swapnext -- direction: r l u d | right,left,up,down
bind("CTRL + TAB", hl.dsp.window.swap({ next = true }), "[" .. windowManagement .. "] swap window") -- OLD swapnext -- direction: r l u d | right,left,up,down

-- Move focus cursor
bind(mainMod .. " + TAB", hl.dsp.window.cycle_next(), "[" .. windowManagement .. "] super+tab")
bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.cycle_next({ prev = true }), "[" .. windowManagement .. "] super+shift+tab")

-- Hyprland Apps
bind("F12", hl.dsp.exec_cmd("killall waybar ; waybar"), "[" .. windowManagement .. "] reload waybar")
bind("CTRL + apostrophe", hl.dsp.exec_cmd("killall waybar ; waybar"), "[" .. windowManagement .. "] reload waybar") -- CTRL+'
bind(mainMod .. " + ALT + l", hl.dsp.exec_cmd("hyprlock"), "[" .. windowManagement .. "] lock screen")
bind(mainMod .. " + ALT + I", hl.dsp.exec_cmd("killall hypridle ; hypridle"),
  "[" .. windowManagement .. "] reload hypridle")

-- Apps principais
bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal), "[" .. launcher .. "|apps] open terminal")
bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), "[" .. launcher .. "|apps] open file manager")
bind(mainMod .. " + W", hl.dsp.exec_cmd(browser), "[" .. launcher .. "|apps] open browser")
bind(mainMod .. " + O", hl.dsp.exec_cmd(notepad), "[" .. launcher .. "|apps] open notepad")
bind(mainMod .. " + C", hl.dsp.exec_cmd(codeEditor), "[" .. launcher .. "|apps] open code editor")


-- Rofi Apps
bind(mainMod .. " + D", hl.dsp.exec_cmd(menu), "[" .. launcher .. "|apps] open app launcher")
bind(mainMod .. " + X", hl.dsp.exec_cmd(powermenu), "[" .. launcher .. "|rofi menus] power menu")
bind("ALT + V", hl.dsp.exec_cmd(cliphist_menu), "[" .. launcher .. "|rofi menus] clipboard history")
bind("F10", hl.dsp.exec_cmd(wallpaper_menu), "[" .. launcher .. "|rofi menus] wallpaper selector")
bind("F11", hl.dsp.exec_cmd(hub_configuration), "[" .. launcher .. "|rofi hub] configuration")


bind(mainMod .. " + semicolon",
  hl.dsp.exec_cmd(
    'rofi -modi emoji -show emoji -theme ~/.config/rofi/catppuccin-list.rasi -display-emoji "󰱨 Emoji " -kb-accept-entry "" -kb-custom-1 Return'),
  "[" .. launcher .. "|rofi menus] open emoji selector")

-- Screenshots
bind("Print", hl.dsp.exec_cmd("hyprshot -m active -m output -o ~/Pictures/Screenshots"),
  "[" .. utilities .. "|screen capture] active monitor screenshot")
bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"),
  "[" .. utilities .. "|screen capture] region screenshot")
bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("hyprshot -m region --raw | satty --filename -"),
  "[" .. utilities .. "|screen capture] annotate screenshot")

-- Misc Apps
bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"), "[" .. utilities .. "|screen capture] color picker")
bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"), "[" .. utilities .. "|screen capture] toggle control center")

-- Focus
bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }), "[" .. windowManagement .. "|change focus] move focus left")
bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }),
  "[" .. windowManagement .. "|change focus] move focus right")
bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }), "[" .. windowManagement .. "|change focus] move focus up")
bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }), "[" .. windowManagement .. "|change focus] move focus down")

-- Move Windows
bind(mainMod .. " + SHIFT + left", move_active_window_or_dispatch("l", { x = -30, y = 0 }),
  "[" .. windowManagement .. "|Move active window] move left", { repeating = true })
bind(mainMod .. " + SHIFT + right", move_active_window_or_dispatch("r", { x = 30, y = 0 }),
  "[" .. windowManagement .. "|Move active window] move right", { repeating = true })
bind(mainMod .. " + SHIFT + up", move_active_window_or_dispatch("u", { x = 0, y = -30 }),
  "[" .. windowManagement .. "|Move active window] move up", { repeating = true })
bind(mainMod .. " + SHIFT + down", move_active_window_or_dispatch("d", { x = 0, y = 30 }),
  "[" .. windowManagement .. "|Move active window] move down", { repeating = true })

-- workspaces
bind(mainMod .. " + code:10", hl.dsp.focus({ workspace = 1 }), "[" .. workspaces .. "] workspace 1")
bind(mainMod .. " + code:11", hl.dsp.focus({ workspace = 2 }), "[" .. workspaces .. "] workspace 2")
bind(mainMod .. " + code:12", hl.dsp.focus({ workspace = 3 }), "[" .. workspaces .. "] workspace 3")
bind(mainMod .. " + code:13", hl.dsp.focus({ workspace = 4 }), "[" .. workspaces .. "] workspace 4")
bind(mainMod .. " + code:14", hl.dsp.focus({ workspace = 5 }), "[" .. workspaces .. "] workspace 5")
bind(mainMod .. " + code:15", hl.dsp.focus({ workspace = 6 }), "[" .. workspaces .. "] workspace 6")
bind(mainMod .. " + code:16", hl.dsp.focus({ workspace = 7 }), "[" .. workspaces .. "] workspace 7")
bind(mainMod .. " + code:17", hl.dsp.focus({ workspace = 8 }), "[" .. workspaces .. "] workspace 8")
bind(mainMod .. " + code:18", hl.dsp.focus({ workspace = 9 }), "[" .. workspaces .. "] workspace 9")
bind(mainMod .. " + code:19", hl.dsp.focus({ workspace = 10 }), "[" .. workspaces .. "] workspace 10")

-- Move Windows workspaces
bind(mainMod .. " + SHIFT + code:10", hl.dsp.window.move({ workspace = 1 }), "[" .. workspaces .. "] move to 1")
bind(mainMod .. " + SHIFT + code:11", hl.dsp.window.move({ workspace = 2 }), "[" .. workspaces .. "] move to 2")
bind(mainMod .. " + SHIFT + code:12", hl.dsp.window.move({ workspace = 3 }), "[" .. workspaces .. "] move to 3")
bind(mainMod .. " + SHIFT + code:13", hl.dsp.window.move({ workspace = 4 }), "[" .. workspaces .. "] move to 4")
bind(mainMod .. " + SHIFT + code:14", hl.dsp.window.move({ workspace = 5 }), "[" .. workspaces .. "] move to 5")
bind(mainMod .. " + SHIFT + code:15", hl.dsp.window.move({ workspace = 6 }), "[" .. workspaces .. "] move to 6")
bind(mainMod .. " + SHIFT + code:16", hl.dsp.window.move({ workspace = 7 }), "[" .. workspaces .. "] move to 7")
bind(mainMod .. " + SHIFT + code:17", hl.dsp.window.move({ workspace = 8 }), "[" .. workspaces .. "] move to 8")
bind(mainMod .. " + SHIFT + code:18", hl.dsp.window.move({ workspace = 9 }), "[" .. workspaces .. "] move to 9")
bind(mainMod .. " + SHIFT + code:19", hl.dsp.window.move({ workspace = 10 }), "[" .. workspaces .. "] move to 10")

-- Mouse
bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), "[" .. workspaces .. "] next workspace")
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), "[" .. workspaces .. "] previous workspace")
bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), "[" .. windowManagement .. "] move window", { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), "[" .. windowManagement .. "] resize window", { mouse = true })

-- Audio
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
  "[" .. hardwareControls .. "] volume up", { locked = true, repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
  "[" .. hardwareControls .. "] volume down", { locked = true, repeating = true })
bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),
  "[" .. hardwareControls .. "] mute", { locked = true, repeating = true })

-- Brightness
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"),
  "[" .. hardwareControls .. "] brightness up", { locked = true, repeating = true })
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"),
  "[" .. hardwareControls .. "] brightness down", { locked = true, repeating = true })
