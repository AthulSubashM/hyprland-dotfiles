local up_keys = { "XF86Macro27", "XF86MonBrightnessUp", Mod .. " + F5" }
local down_keys = { "XF86Macro28", "XF86MonBrightnessDown", Mod .. " + F4" }

-- Loop for Brightness Up
for _, key in ipairs(up_keys) do
	hl.bind(key, hl.dsp.exec_cmd("swayosd-client --brightness raise"), {
		repeating = true,
		locked = true,
	})
end

-- Loop for Brightness Down
for _, key in ipairs(down_keys) do
	hl.bind(key, hl.dsp.exec_cmd("swayosd-client --brightness lower"), {
		repeating = true,
		locked = true,
	})
end
