hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,
		numlock_by_default = true,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
hl.gesture({
	fingers = 2,
	direction = "pinch",
	mods = "SUPER",
	action = "cursorZoom",
	zoom_level = 1,
	mode = "live",
})

hl.gesture({
	fingers = 3,
	direction = "up",
	action = function()
		hl.exec_cmd("fuzzel")
	end,
})
hl.gesture({
	fingers = 3,
	direction = "down",
	action = function()
		hl.exec_cmd("firefox")
	end,
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
