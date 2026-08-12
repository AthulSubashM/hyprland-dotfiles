require("settings.themes.animations")
local wal = require("settings.themes.colors")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- source = ~/.config/hypr/settings/themes/colors/catppucin_mocha.conf
-- source = ~/.cache/wal/colors-hyprland

local font = "Open Sans"

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = {
			top = 40,
			right = 4,
			bottom = 4,
			left = 4,
		},
		border_size = 2,
		-- col.active_border = rgba(918a97aa),
		-- no_border_on_floating = true,

		col = {
			active_border = wal.color2,
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
		-- layout = "scrolling",
	},

	-- https://wiki.hypr.land/Configuring/Variables/#decoration
	decoration = {
		rounding = 5,
		rounding_power = 2,

		dim_special = 0.5,

		-- Change transparency of focused and unfocused windows
		active_opacity = 0.98,
		inactive_opacity = 0.85,
		fullscreen_opacity = 1,

		shadow = {
			enabled = true,
			range = 16,
			offset = { 0, 4 },
			render_power = 3,
			color = { colors = { "rgba(1a1a1a88)", "rgba(00000033)" }, angle = 45 },
			-- color = wal.background,
			-- ignore_window = false,
		},

		-- https://wiki.hypr.land/Configuring/Variables/#blur
		blur = {
			size = 8,
			passes = 2,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
			popups = true,
		},
		motion_blur = {
			enabled = true,
		},
	},

	animations = {
		enabled = true,
	},
	scrolling = {
		column_width = 0.495,
	},

	-- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
	dwindle = {
		-- pseudotile = true, -- Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
		preserve_split = true, -- You probably want this
		force_split = 2, -- Split to right
	},

	-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
	master = {
		new_status = "slave",
		allow_small_split = true,
	},

	-- https://wiki.hypr.land/Configuring/Variables/#misc
	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		font_family = font,
		-- animate_mouse_windowdragging = true,
		-- animate_manual_resizes = true,
		-- enable_swallow = true
		-- swallow_regex = ^(kitty)$
	},

	group = {
		col = { border_active = wal.color0 },

		auto_group = false,
		drag_into_group = 2,
		merge_groups_on_drag = false,
		merge_groups_on_groupbar = true,

		groupbar = {
			font_family = font,
			font_size = 11,
			font_weight_active = "semibold",
			gaps_in = 1,
			gaps_out = 0,
			gradients = true,
			height = 20,
			indicator_height = 0,
			gradient_rounding = 5,
			gradient_rounding_power = 2,
			gradient_round_only_edges = false,

			text_color_inactive = wal.color8,
			col = {
				active = wal.color1,
				inactive = wal.background,
			},
		},
	},

	cursor = {
		inactive_timeout = 10,
	},
})
