Mod = "SUPER"
-- plugins and colors
require("settings.monitors")
require("settings.autostart")
require("settings.rules.environment")
require("settings.rules.layerrules")
require("settings.rules.windowrules")
require("settings.permissions")
require("settings.keybinds.key-binds")
require("settings.themes.general")
-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})
