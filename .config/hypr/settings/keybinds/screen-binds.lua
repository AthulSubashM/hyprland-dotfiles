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

-- Toggle Laptop Screen ON/OFF
hl.bind(Mod .. " + F6", function()
	local mode_status = hl.get_monitor("eDP-1")
	if mode_status ~= nil and not mode_status.disabled then
		os.execute("brightnessctl -s")
		hl.monitor({ output = "eDP-1", disabled = true })
	else
		hl.monitor({
			output = "eDP-1",
			disabled = false,
			mode = "preferred",
			position = "auto",
			scale = 1,
		})
		os.execute("(sleep 0.3 && brightnessctl -r) &")
	end
end)

-- Asus monitor
hl.bind(Mod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/asus_brightness_mako.sh +10"))
hl.bind(Mod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/asus_brightness_mako.sh -10"))

-- Monitor to Vertical
hl.bind(Mod .. " + XF86AudioMute", function()
	local current_transform = 0
	for _, m in ipairs(hl.get_monitors()) do
		if m.description and m.description:find("VG27AQL5A", 1, true) then
			current_transform = m.transform
			break
		end
	end

	hl.monitor({
		output = "desc:ASUSTek COMPUTER INC VG27AQL5A W5LMQS009449",
		mode = "2560x1440@60",
		position = "auto",
		scale = 1,
		vrr = 0,
		transform = (current_transform == 0) and 1 or 0,
	})
end)

-- Toggle ASUS VG27AQL5A between 1440p@60 and 1080p@120
hl.bind(Mod .. " + F7", function() -- Swap F7 for whatever keybind you prefer
	local is_1440p = true
	local current_transform = 0

	for _, m in ipairs(hl.get_monitors()) do
		if m.description and m.description:find("VG27AQL5A", 1, true) then
			is_1440p = (m.width == 2560)
			current_transform = m.transform
			break
		end
	end

	local next_mode = is_1440p and "1920x1080@120" or "2560x1440@60"

	hl.monitor({
		output = "desc:ASUSTek COMPUTER INC VG27AQL5A W5LMQS009449",
		mode = next_mode,
		position = "auto",
		scale = 1,
		vrr = 0,
		transform = current_transform,
	})

	hl.exec_cmd(
		string.format(
			'notify-send -a asus-brightness -t 1500 -h string:x-canonical-private-synchronous:asus-mode "    %s"',
			next_mode
		)
	)
end)

-- Toggle ASUS VG27AQL5A between 1440p@60 and 1080p@120
hl.bind(Mod .. " + F8", function()
	local is_1440p = true
	local current_transform = 0

	for _, m in ipairs(hl.get_monitors()) do
		if m.description and m.description:find("VG27AQL5A", 1, true) then
			is_1440p = (m.width == 2560 or m.height == 2560)
			current_transform = m.transform
			break
		end
	end

	local next_mode = is_1440p and "1920x1080@120" or "2560x1440@60"
	local label = is_1440p and "1080p @ 120Hz" or "1440p @ 60Hz"
	local color = is_1440p and "rgb(40a02b)" or "rgb(ff0029)"

	hl.monitor({
		output = "desc:ASUSTek COMPUTER INC VG27AQL5A W5LMQS009449",
		mode = next_mode,
		position = "auto",
		scale = 1,
		vrr = 0,
		transform = current_transform,
	})

	hl.exec_cmd(string.format("hyprctl notify -1 5000 '%s' 'fontsize:16  󰹑   %s'", color, label))
end)

-- Asus Visual Game modes
hl.bind(Mod .. " + F9", hl.dsp.exec_cmd("~/.config/fuzzel/dmenus/asus_gamevisualmodes.ini"))
