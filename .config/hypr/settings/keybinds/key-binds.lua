Mod = "SUPER"

require("settings.keybinds.mouse")
require("settings.keybinds.screen-binds")
require("settings.keybinds.volume-binds")
require("settings.keybinds.workspaces-binds")

--------------------
--    PROGRAMS    --
-------------------
local terminal = "kitty"
local terminal2 = "alacritty"

local fileManager = terminal .. " -e yazi"
local GUIfileManager = "thunar"
-- local menu = "wofi --show drun -n
local menu = "fuzzel"
local browser = "firefox"
local browser2 = "brave-origin"
local taskManager = terminal2 .. " -T btop -e btop"
-- local local notifications = "swaync-client -t -sw
local notifications = "makoctl"
local editor = terminal2 .. " -e nvim"
local editor2 = "antigravity"
local mail = terminal .. " -e aerc"
local shell = editor .. " .bashrc"

--------------------------
--    SYSTEM CONTROLS   --
--------------------------
hl.bind(Mod .. "+C", hl.dsp.window.close())
hl.bind(Mod .. "+SHIFT+C", hl.dsp.window.kill())

-- Kill all windows in the active workspace
hl.bind(Mod .. "+CTRL+C", function()
	-- Get the active workspace object
	local active_ws = hl.get_active_workspace()
	if not active_ws then
		return
	end

	local active_ws_id = active_ws.id

	-- Fetch all current windows
	local windows = hl.get_windows()
	if not windows then
		return
	end

	-- Loop through and close windows belonging to the active workspace
	for _, win in ipairs(windows) do
		if win.workspace and win.workspace.id == active_ws_id then
			-- Pass the window target to the close dispatcher explicitly
			hl.dispatch(hl.dsp.window.close({ window = string.format("address:%s", win.address) }))
		end
	end
end)

hl.bind(Mod .. "+SHIFT+R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("Caps_Lock", hl.dsp.exec_cmd("swayosd-client --caps-lock"))
hl.bind("Num_Lock", hl.dsp.exec_cmd("swayosd-client --num-lock"))

-- Zoom in, out & reset
-- bind = $mod CTRL, mouse_down, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')
-- bind = $mod CTRL, mouse_up, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')
-- bind = $mod CTRL, 0, exec, hyprctl -q keyword cursor:zoom_factor 1
-- binde = $mod CTRL, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')
-- binde = $mod CTRL, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')
--
----------------------
--    MENU BINDS    --
----------------------
--See windowrules for notes
hl.bind(
	Mod .. "+N",
	hl.dsp.exec_cmd("env YAZI_CONFIG_HOME=$HOME/.config/yazi/notes alacritty -T 'notes' -e yazi '~/Documents/notes'")
)
hl.bind(Mod .. "+M", hl.dsp.exec_cmd("~/.config/hypr/scripts/dmenu/man_pages.sh"))
hl.bind(Mod .. "+X", hl.dsp.exec_cmd("~/.config/hypr/scripts/dmenu/kill_process.sh"))
hl.bind(Mod .. "+ALT+M", hl.dsp.exec_cmd("~/.config/hypr/scripts/dmenu/arch_wiki_search.sh"))
hl.bind(Mod .. "+R", hl.dsp.exec_cmd("~/.config/hypr/scripts/rename_workspace.sh"))

--------------------------
--    WINDOW CONTROLS   --
--------------------------
-- Groups
hl.bind(Mod .. "+G", hl.dsp.group.toggle())
hl.bind(Mod .. "+ALT+Tab", hl.dsp.group.next())
hl.bind(Mod .. "+Control_L+Tab", hl.dsp.group.prev())

-- Mouse: 272:left, 273:right, 274:middle, 275:button4, 276:button5
-- Resize windows

hl.bind(Mod .. " + minus", hl.dsp.window.resize({ x = -200, y = 0, relative = true }))
hl.bind(Mod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -200, relative = true }))
hl.bind(Mod .. " + equal", hl.dsp.window.resize({ x = 200, y = 0, relative = true }))
hl.bind(Mod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 200, relative = true }))

hl.bind(Mod .. " + mouse:275", hl.dsp.window.resize({ x = -200, y = 0, relative = true }))
hl.bind(Mod .. " + mouse:276", hl.dsp.window.resize({ x = 200, y = 0, relative = true }))
--
-- Move/resize windows with Mod + LMB/RMB and dragging
hl.bind(Mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(Mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(Mod .. " + mouse:274", hl.dsp.window.drag(), { mouse = true })

-- Move focus with Mod + arrow keys
hl.bind(Mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(Mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(Mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(Mod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Modes
hl.bind(Mod .. "+K", hl.dsp.window.fullscreen())
hl.bind(Mod .. "+F", hl.dsp.window.float())
hl.bind(Mod .. "+P", hl.dsp.window.pin())
hl.bind(Mod .. "+SHIFT+F", hl.dsp.exec_cmd(" ~/.config/hypr/scripts/mini_player.sh"))
hl.bind(Mod .. "+ALT+P", hl.dsp.window.pseudo())
hl.bind(Mod .. "+J", hl.dsp.layout("togglesplit"))
-- hl.bind(Mod.."+TAB", hl.dsp.window.fullscreen())
-- bind = $mod, TAB, hyprexpo:expo, toggle - Hyprexpo
-- hl.bind(Mod .. "+TAB", "hymission:toggle")

hl.bind(Mod .. "+O", hl.dsp.window.set_prop({ prop = "opaque", value = 1 }))
hl.bind(Mod .. "+ALT+O", hl.dsp.window.set_prop({ prop = "opaque", value = 0 }))

-----------------------
--    APPLICATIONS   --
-----------------------
-- Core Applications
hl.bind(Mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(Mod .. " + ALT + E", hl.dsp.exec_cmd(GUIfileManager))
hl.bind(Mod .. " + T", hl.dsp.exec_cmd(terminal2))
hl.bind(Mod .. " + ALT + T", hl.dsp.exec_cmd(terminal))
hl.bind(Mod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(Mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(Mod .. " + ALT + B", hl.dsp.exec_cmd(browser2))
hl.bind(Mod .. " + Q", hl.dsp.exec_cmd(taskManager))

-- Specific Commands & Scripts
hl.bind(Mod .. " + A", hl.dsp.exec_cmd("wofi --show drun --conf=~/.config/wofi/grid.conf"))
hl.bind(Mod .. " + ALT + space", hl.dsp.exec_cmd("~/.config/hypr/scripts/fzf_search.sh"))
hl.bind(Mod .. " + V", hl.dsp.exec_cmd(editor))
hl.bind(Mod .. " + ALT + V", hl.dsp.exec_cmd(editor2))
hl.bind(Mod .. " + ALT + N", hl.dsp.exec_cmd("~/.config/hypr/scripts/dmenu/notifications_history.sh"))
hl.bind(Mod .. " + D", hl.dsp.exec_cmd(notifications .. " dismiss --no-history"))
hl.bind(Mod .. " + CTRL + M", hl.dsp.exec_cmd(mail))
hl.bind(Mod .. " + CTRL + V", hl.dsp.exec_cmd(shell))

hl.bind(Mod .. "+ CTRL + B", hl.dsp.exec_cmd("~/.config/waybar/scripts/toggle-bluetooth-gui.sh"))
hl.bind(Mod .. "+ CTRL + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-pavucontrol.sh"))
hl.bind(Mod .. "+ CTRL + N", hl.dsp.exec_cmd("nm-sidebar --toggle"))
-- hl.bind(Mod .. "+ CTRL + N", hl.dsp.exec_cmd("~/.config/waybar/scripts/toggle-network-gui.sh"))

-- Screenshot
local ssdir = "~/Pictures/Screenshots/"
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui")) -- gui
hl.bind(Mod .. "+ PRINT", hl.dsp.exec_cmd("flameshot full -p " .. ssdir)) -- full to file
hl.bind(Mod .. "+ CTRL + PRINT", hl.dsp.exec_cmd("flameshot full -c")) -- full to clipboard

-- hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output -o " .. ssdir)) -- Monitor to file
-- hl.bind(Mod .. "+PRINT", hl.dsp.exec_cmd("hyprshot -m window -o " .. ssdir)) -- Window to file
-- hl.bind(Mod .. "+SHIFT+PRINT", hl.dsp.exec_cmd("hyprshot -m region -o " .. ssdir)) -- Region to file
--
-- hl.bind("CTRL+PRINT", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only  -o " .. ssdir)) -- Monitor to clipboard
-- hl.bind(Mod .. "+CTRL+PRINT", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only  -o " .. ssdir)) -- Window to clipboard
-- hl.bind(Mod .. "+CTRL+SHIFT+PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only  -o " .. ssdir)) -- Region to clipboard
--
-- Clipboard
hl.bind(Mod .. "+SHIFT+V", hl.dsp.exec_cmd("cliphist list | " .. menu .. " --dmenu | cliphist decode | wl-copy"))

---------------------------
--    SWITCHERS & MODES  --
---------------------------
-- Wallpaper Switchers
-- bind = $mod, W, exec, ~/.config/hypr/scripts/wallpaper_switcher.sh
hl.bind(Mod .. "+W", hl.dsp.exec_cmd("waypaper --random"))
hl.bind(Mod .. "+ALT+W", hl.dsp.exec_cmd("waypaper"))

-- Game Mode
hl.bind("SUPER + F10", function()
	local game_mode = (hl.get_config("animations.enabled") == false)

	if game_mode then
		hl.exec_cmd("hyprctl reload")
		hl.exec_cmd("hyprctl notify 1 3000 'rgb(40a02b)' 'Gamemode [OFF]'")
		return
	end

	hl.config({
		general = {
			gaps_in = 0,
			gaps_out = 0, -- Disable gaps
			border_size = 0,
		},

		animations = {
			enabled = false, -- Disable animations
		},

		-- Disable blur, shadow, opacity, rounding and window rounding
		decoration = {
			shadow = { enabled = false },
			blur = { enabled = false },
			rounding = 0,
			active_opacity = 1,
			inactive_opacity = 1,
		},
	})
	hl.exec_cmd("hyprctl notify 1 3000 'rgb(40a02b)' 'Gamemode [ON]'")
end)

-- Hyprbars
hl.bind(Mod .. "+F7", hl.dsp.exec_cmd("hyprctl dispatch 'hl.config({plugin = {hyprbars = {enabled = 1}}})'"))
hl.bind(Mod .. "+ALT+F7", hl.dsp.exec_cmd("hyprctl dispatch 'hl.config({plugin = {hyprbars = {enabled = 0}}})'"))

------------------------
--    POWER OPTIONS   --
------------------------
hl.bind(Mod .. "+ALT+CTRL+SHIFT+X", hl.dsp.exec_cmd("shutdown now"))
hl.bind(Mod .. "+SHIFT+H", hl.dsp.exec_cmd("systemctl hibernate && hyprlock"))
hl.bind(Mod .. "+Z", hl.dsp.exec_cmd("~/.config/hypr/scripts/dmenu/power_menu.sh"))
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("wlogout"))
hl.bind(Mod .. "+L", hl.dsp.exec_cmd("hyprlock"))
