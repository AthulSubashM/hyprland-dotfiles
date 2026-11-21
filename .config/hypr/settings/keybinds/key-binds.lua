Mod = "SUPER"

require("settings.keybinds.mouse")
require("settings.keybinds.screen-binds")
require("settings.keybinds.volume-binds")

local sub = require("settings.keybinds.submap_binds")
local utils = require("settings.keybinds.utils")

--------------------
--    PROGRAMS    --
-------------------
local terminal = "kitty"
local terminal2 = "alacritty"

local fileManager = terminal .. " -e yazi"
local GUIfileManager = "thunar"
-- local menu = "wofi --show drun -n
local menu = "fuzzel"
local browser = 'firefox --no-remote --profile "$HOME/.mozilla/firefox/5iflnsw1.default-release/"'
local browser2 = "brave-origin"
local taskManager = terminal2 .. " -T btop -e btop"
-- local local notifications = "swaync-client -t -sw
local notifications = "makoctl"
local editor = terminal2 .. " -e nvim"
local editor2 = "antigravity"
local mail = terminal .. " -e aerc"
local shell = editor .. " .bashrc"

--------------------------
--    Bind Functions    --
--------------------------
-- cmd=exec_cmd(*)
local function execkey(key, cmd)
	hl.bind(Mod .. "+" .. key, function()
		utils.notify(key)
		hl.exec_cmd(cmd)
	end)
end

-- fun=dsp.group.*
local function grpkey(key, fun)
	hl.bind(Mod .. "+" .. key, function()
		utils.notify(key)
		hl.dispatch(hl.dsp.group[fun]())
	end)
end
-- fun=dsp.window.* & args=fun(*)
local function winkey(key, fun, args)
	hl.bind(Mod .. "+" .. key, function()
		utils.notify(key)
		hl.dispatch(hl.dsp.window[fun](args))
	end)
end
-- fun=dsp.* & args=fun(*)
local function dspkey(key, fun, args)
	hl.bind(Mod .. "+" .. key, function()
		utils.notify(key)
		hl.dispatch(hl.dsp[fun](args))
	end)
end

-- fun=local function
local function funkey(key, fun)
	hl.bind(Mod .. "+" .. key, function()
		utils.notify(key)
		fun()
	end)
end

local function subkey(key, fun)
	hl.bind(Mod .. "+" .. key, function()
		utils.notify(key)
		sub.submap(key, fun)
	end)
end

--------------------------
--    SYSTEM CONTROLS   --
--------------------------
funkey("C", utils.close_and_push)
funkey("Z", utils.undo_close)
winkey("SHIFT + C", "kill")
funkey("CTRL + C", utils.kill_workspace)
execkey("+SHIFT + R", "hyprctl reload")

hl.bind("Caps_Lock", hl.dsp.exec_cmd("swayosd-client --caps-lock"))
hl.bind("Num_Lock", hl.dsp.exec_cmd("swayosd-client --num-lock"))

----------------------
--    MENU BINDS    --
----------------------
execkey("N", "marktext")
execkey("M", "~/.config/hypr/scripts/dmenu/man_pages.sh")
execkey("ALT + X", "~/.config/hypr/scripts/dmenu/kill_process.sh")
execkey("ALT + M", "~/.config/hypr/scripts/dmenu/arch_wiki_search.sh")
execkey("ALT + R", "~/.config/hypr/scripts/rename_workspace.sh")

-----------------------
--    APPLICATIONS   --
-----------------------
-- Core Applications
execkey("ALT + E", fileManager)
execkey("E", GUIfileManager)
execkey("T", terminal2)
execkey("ALT + T", terminal)
execkey("space", menu)
execkey("B", browser)
execkey("SHIFT + B", 'firefox --no-remote --profile "$HOME/.mozilla/firefox/lJdOmGgJ.Profile 1" --name "firefox-work"')
execkey("ALT + B", browser2)
execkey("Q", taskManager)

-- Specific Commands & Scripts
execkey("A", "wofi --show drun --conf=~/.config/wofi/grid.conf")
execkey("ALT + space", "~/.config/hypr/scripts/fzf_search.sh")
execkey("V", editor)
execkey("ALT + V", editor2)
execkey("ALT + N", "~/.config/hypr/scripts/dmenu/notifications_history.sh")
execkey("D", notifications .. " dismiss --no-history")
execkey("CTRL + M", mail)
execkey("CTRL + V", shell)

execkey("CTRL + B", "~/.config/waybar/scripts/toggle-bluetooth-gui.sh")
execkey("CTRL + A", "~/.config/hypr/scripts/toggle-pavucontrol.sh")
execkey("CTRL + N", "nm-sidebar --toggle")

-- Screenshot
local ssdir = "~/Pictures/Screenshots/"
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui")) -- gui
execkey("PRINT", "flameshot full -p " .. ssdir) -- full to file
execkey("CTRL + PRINT", "flameshot full -c") -- full to clipboard

-- Clipboard
execkey("SHIFT + V", "cliphist list | " .. menu .. " --dmenu | cliphist decode | wl-copy")

--------------------------
--    WINDOW CONTROLS   --
--------------------------
-- Groups
grpkey("G", "toggle")
grpkey("ALT + G", "next")
grpkey("CTRL+  G", "prev")

-- Resize windows
subkey("R", "resize")

winkey("minus", "resize", { x = -200, y = 0, relative = true })
winkey("equal", "resize", { x = 200, y = 0, relative = true })
winkey("SHIFT + equal", "resize", { x = 0, y = -200, relative = true })
winkey("SHIFT + minus", "resize", { x = 0, y = 200, relative = true })

-- Mouse: 272:left, 273:right, 274:middle, 275:button4, 276:button5
hl.bind(Mod .. " + mouse:275", hl.dsp.window.resize({ x = -200, y = 0, relative = true }))
hl.bind(Mod .. " + mouse:276", hl.dsp.window.resize({ x = 200, y = 0, relative = true }))
--
-- Move/resize windows with Mod + LMB/RMB and dragging
hl.bind(Mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(Mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(Mod .. " + mouse:274", hl.dsp.window.drag(), { mouse = true })

-- Move focus with Mod + arrow keys
dspkey("left", "focus", { direction = "left" })
dspkey("right", "focus", { direction = "right" })
dspkey("up", "focus", { direction = "up" })
dspkey("down", "focus", { direction = "down" })

-- Modes
winkey("K", "fullscreen")
winkey("F", "float")
winkey("P", "pin")
winkey("ALT + P", "pseudo")
execkey("SHIFT + F", " ~/.config/hypr/scripts/mini_player.sh")

winkey("O", "set_prop", { prop = "opaque", value = 1 })
winkey("ALT + O", "set_prop", { prop = "opaque", value = 0 })

---------------------------
--    SWITCHERS & MODES  --
---------------------------
-- Wallpaper Switchers
execkey("W", "waypaper --random")
execkey("ALT + W", "waypaper")

funkey("F10", utils.game_mode)

-- Hyprbars
execkey("F7", "hyprctl dispatch 'hl.config({plugin = {hyprbars = {enabled = 1}}})'")
execkey("ALT + F7", "hyprctl dispatch 'hl.config({plugin = {hyprbars = {enabled = 0}}})'")

------------------------
--     WORKSPACES     --
------------------------
-- Switch workspaces with Mod + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	dspkey(key, "focus", { workspace = i })
	winkey("SHIFT + " .. key, "move", { workspace = i })
	winkey("CTRL + SHIFT + " .. key, "move", { workspace = i, follow = false })
end

-- Work workspace
dspkey("grave", "focus", { workspace = "W" })
winkey("SHIFT + grave", "move", { workspace = "W" })
winkey("CTRL + SHIFT + grave", "move", { workspace = "W", follow = false })

-- scratchpad
hl.bind(Mod .. " + S", function()
	utils.notify("S")
	hl.dispatch(hl.dsp.workspace.toggle_special("S"))
end)
winkey("SHIFT + S", "move", { workspace = "special:S" })

-- Scroll through existing workspaces with Mod + scroll
hl.bind(Mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(Mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
dspkey("CTRL + right", "focus", { workspace = "e+1" })
dspkey("CTRL + left", "focus", { workspace = "e-1" })

funkey(
	"J",
	utils.layout_bind({
		scrolling = hl.dsp.layout("swapcol r"), -- Scrolling: swap column with left one
		dwindle = hl.dsp.layout("togglesplit"), -- Dwindle: swap window split
	})
)

funkey(
	"H",
	utils.layout_bind({
		scrolling = hl.dsp.layout("swapcol l"),
		dwindle = hl.dsp.layout("swapsplit"),
	})
)

funkey("period", utils.switch_layouts)

-- funkey("TAB", hl.plugin.gloview.toggle)
------------------------
--    POWER OPTIONS   --
------------------------
execkey("CTRL+SHIFT+X", "shutdown now")
execkey("SHIFT+H", "systemctl hibernate")
execkey("X", "~/.config/hypr/scripts/dmenu/power_menu.sh")
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("wlogout"))
execkey("L", "hyprlock")
