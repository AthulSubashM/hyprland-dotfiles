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

hl.monitor({
	output = "desc: ASUSTek COMPUTER INC VG27AQL5A W5LMQS009449",
	mode = "2560x1440@60",
	-- mode = "1920x1080@120",
	position = "auto",
	scale = 1,
	vrr = 2,
})

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})
