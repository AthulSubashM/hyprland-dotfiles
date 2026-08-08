local wal = require("settings.themes.colors")

hl.config({
	plugin = {
		hyprbars = {
			bar_height = 20,
			bar_blur = 1,
			enabled = 0,
		},
		gloview = {
			show_special = 1,
		},
	},
})

hl.plugin.hyprbars.add_button({
	bg_color = wal.color1,
	fg_color = "rgb(ffffff)",
	size = 15,
	icon = "X",
	action = "hyprctl dispatch 'hl.dsp.window.close(activewindow)'",
})

hl.plugin.hyprbars.add_button({
	bg_color = wal.color2,
	fg_color = "rgb(ffffff)",
	size = 15,
	icon = "□",
	action = "hyprctl dispatch 'hl.dsp.window.fullscreen_state({internal=1,client=1,toggle,activewindow})'",
})
hl.plugin.hyprbars.add_button({
	bg_color = wal.color3,
	fg_color = "rgb(ffffff)",
	size = 15,
	icon = "-",
	action = "hyprctl dispatch 'hl.dsp.window.fullscreen_state({internal=0,client=0,toggle,activewindow})'",
})

-- Hyprexpo
-- plugin {
--     hyprexpo {
--         columns = 2
--         gap_size = 5
--         bg_col = rgb(000000)
--         workspace_method = first 1 # [center/first] [workspace] e.g. first 1 or center m+1
--         # gesture_distance = 300 # how far is the "max" for the gesture
--     }
--     dynamic-cursors {
--
--   }
-- }
