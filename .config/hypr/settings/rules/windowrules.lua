-- source = ~/.config/hypr/settings/themes/colors/catppucin_mocha.conf

local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Floating general rule
hl.window_rule({
	name = "float-opaque",
	match = { float = true },
	opaque = true,
})
-- Define your colors
local mauve = "0xffcba6f7"
local crust = "0xff11111b"

-- Rule for Network Manager GUI
hl.window_rule({
	name = "nm-editor",
	match = { class = "^(nm-connection-editor)$" },
	float = true,
	-- FIXED: Use string expressions in an array format
	size = { "monitor_w * 0.25", "monitor_h * 0.4" },
	move = { "monitor_w * 0.745", "monitor_h * 0.05" },
})

-- Rule for Bluetooth Manager GUI
hl.window_rule({
	name = "blueman",
	match = { class = "^(blueman-manager)$" },
	float = true,
	size = { "monitor_w * 0.3", "monitor_h * 0.5" },
	move = { "monitor_w * 0.69", "monitor_h * 0.05" },
	animation = "slide",
	border_size = 0,
})
hl.window_rule({
	name = "overskride",
	match = { title = "^(overskride)$" },
	float = true,
	-- size = { "monitor_w * 0.3", "monitor_h * 0.5" },
	move = { "monitor_w * 0.677", "monitor_h * 0.05" },
	animation = "slide",
	border_size = 0,
})

-- Rule for Volume Control (Pavucontrol)
hl.window_rule({
	name = "pavucontrol",
	match = { class = "^(org.pulseaudio.pavucontrol)$" },
	float = true,
	size = { "monitor_w * 0.3", "monitor_h * 0.3" },
	move = { "monitor_w * 0.699", "monitor_h * 0.037" },
	animation = "slide",
	border_size = 0,
	opacity = "0.8",
	opaque = false,
})
hl.window_rule({
	name = "pwvucontrol",
	match = { class = "^(com.saivert.pwvucontrol)$" },
	float = true,
	size = { "monitor_w * 0.48", "monitor_h * 0.5" },
	move = { "monitor_w * 0.515", "monitor_h * 0.05" },
	animation = "slide",
	border_size = 0,
})

-- Rule for nmtui
hl.window_rule({
	name = "nmtui-float",
	match = { class = "^(nmtui-float)$" },
	float = true,
	size = { "monitor_w * 0.4", "monitor_h * 0.5" },
	move = { "monitor_w * 0.3", "monitor_h * 0.25" },
})

-- Rules for notes menu
hl.window_rule({
	name = "notes-menu",
	match = { title = "^(notes)$" },
	float = true,
	border_size = 0,
	size = { "monitor_w * 0.5", "monitor_h * 0.5" },
	opaque = true,
})

-- Smart Gaps (Workspace Rules)
-- Note: 'match' is the correct property for workspace rules in 0.55+
hl.workspace_rule({
	workspace = "w[tv1]",
	gaps_out = 0,
	gaps_in = 0,
})
hl.workspace_rule({
	workspace = "f[1]",
	gaps_out = 0,
	gaps_in = 0,
})

hl.window_rule({
	name = "no-gaps-wtv1",
	match = { float = false, workspace = "w[tv1]" },
	border_size = 0,
	rounding = 0,
})

hl.window_rule({
	name = "no-gaps-f1",
	match = { float = false, workspace = "f[1]" },
	border_size = 0,
	rounding = 0,
})

-- Picture in Picture
hl.window_rule({
	name = "pip",
	match = { title = "^Picture-in-Picture$" },
	float = true,
	size = { "600", "340" },
})

-- FZF Search
hl.window_rule({
	name = "fzf-search",
	match = { title = "^(FZF_Search)$" },
	float = true,
	border_size = 1,
	rounding = 0,
	dim_around = true,
	animation = "slide 20%",
	size = { "1200", "600" },
})

-- Whatsapp Web
hl.window_rule({
	name = "whatsapp",
	match = { class = "^(chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Default)$" },
	float = true,
	border_size = 0,
	size = { "800", "600" },
	move = { "monitor_w * 0.1", "monitor_h * 0.1" },
})

-- Hyprpolkitagent
hl.window_rule({
	name = "polkit",
	match = { class = "^(hyprpolkitagent)$" },
	dim_around = true,
	animation = "popin",
})

-- Pinned windows
hl.window_rule({
	name = "pinned-style",
	match = { pin = true },
	-- FIXED: In 0.55+, colors are often defined as 'border_color'
	-- and accept a string or table gradient
	border_color = mauve .. " " .. crust,
	opaque = true,
})

-- Image viewer
hl.window_rule({
	name = "ristretto-rule",
	match = { class = "^(ristretto)$" },
	float = true,
	size = { "800", "600" },
	opaque = true,
	no_blur = true,
})

-- Waypaper
hl.window_rule({
	name = "waypaper-rule",
	match = { class = "^(waypaper)$" },
	float = true,
})

hl.window_rule({
	name = "btop-rule",
	match = { title = "^(btop)$" },
	float = true,
	size = { "1200", "800" },
	border_size = 0,
	rounding = 0,
})

-- Firefox
hl.on("window.title", function(w)
	if w ~= nil and w.title == "Extension: (Bitwarden Password Manager) - Bitwarden — Mozilla Firefox" then
		hl.dispatch(hl.dsp.window.float({ action = "set" }))
		hl.dispatch(hl.dsp.window.center())
	end
end)
hl.window_rule({
	match = { class = "^(firefox-work)$" },
	workspace = "name:W",
})
