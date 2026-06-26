-- Waybar Blur
hl.layer_rule({
	name = "waybar-blur",
	match = { namespace = "waybar" },
	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	name = "nm-sidebar-blur",
	match = { namespace = "nm-sidebar" },
	blur = true,
	ignore_alpha = 0.5,
})

-- Layer Rules for Fuzzel (Launcher)
hl.layer_rule({
	name = "launcher-dim",
	match = { namespace = "launcher" },
	dim_around = true,
	animation = "slide",
})

-- Wlogout (Above Lockscreen)
hl.layer_rule({
	name = "wlogout-layer",
	match = { namespace = "logout_dialog" },
	-- 2 = interactive on lockscreen according to your docs
	above_lock = 2,
})
