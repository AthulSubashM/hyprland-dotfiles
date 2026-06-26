hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-- SlyTV
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "auto",
	scale = 1,
	vrr = 0,
})

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})
