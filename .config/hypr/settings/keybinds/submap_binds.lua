local wal = require("settings.themes.colors")
local utils = require("settings.keybinds.utils")
-- Submap

-- Show submap name
local function notify_name(name)
	hl.exec_cmd(
		string.format('notify-send -a "submap" -h string:x-canonical-private-synchronous:submap "%s Mode"', name)
	)
end

-- Show tooltip
local function tooltip()
	hl.exec_cmd(
		'notify-send -a "submap-tooltip"  -h string:x-canonical-private-synchronous:submap-tooltip "Q to Exit Submap" '
	)
end

-- Remove submap name
local function remove_notify()
	hl.exec_cmd('notify-send -u "critical" -a "submap" -h string:x-canonical-private-synchronous:submap ""')
end

-- Submap exit
local function exitsubmap(key)
	hl.bind(key, function()
		utils.short_notify(key)
		remove_notify()
		hl.config({
			general = { border_size = 2, gaps_in = 2, col = { active_border = wal.color2 } },
			decoration = { dim_inactive = false },
			group = { col = { border_active = wal.color1 } },
		})
		hl.dispatch(hl.dsp.submap("reset"))
	end)
end

-- fun=dsp.* & args=fun(*)
local function dspkey(key, fun, args)
	hl.bind(key, function()
		utils.short_notify(key)
		hl.dispatch(hl.dsp[fun](args))
	end)
end

-- submap entry
local function submap(key, name)
	local str = string.gsub(name, "^%l", string.upper)
	notify_name(str)
	tooltip()

	hl.dispatch(hl.dsp.submap(name))
	hl.config({
		general = { border_size = 6, gaps_in = 2, col = { active_border = wal.color5 } },
		decoration = { dim_inactive = true },
		group = { col = { border_active = wal.color5 } },
	})
end

-- Resize submap
hl.define_submap("resize", function()
	hl.bind("D", function()
		utils.short_notify("D")
		hl.dispatch(hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
	end, { repeating = true })
	hl.bind("A", function()
		utils.short_notify("A")
		hl.dispatch(hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
	end, { repeating = true })
	hl.bind("W", function()
		utils.short_notify("W")
		hl.dispatch(hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
	end, { repeating = true })
	hl.bind("S", function()
		utils.short_notify("S")
		hl.dispatch(hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
	end, { repeating = true })

	dspkey("left", "focus", { direction = "left" })
	dspkey("right", "focus", { direction = "right" })
	dspkey("up", "focus", { direction = "up" })
	dspkey("down", "focus", { direction = "down" })

	exitsubmap("Q")
	exitsubmap("escape")
end)

return {
	submap = submap,
	notify_name = notify_name,
	remove_notify = remove_notify,
}
