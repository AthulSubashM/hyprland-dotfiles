require("settings.themes.animations")
local wal = require("settings.themes.colors")

local key_symbols = {
	left = "←",
	right = "→",
	up = "↑",
	down = "↓",
	["return"] = "󰌑",
	space = "␣",
	backspace = "⌫",
	escape = "ESC",
	period = ".",
	comma = ",",
}

-- notify keybind
local function notify(key)
	key = key_symbols[key] or key
	-- Use 'low' urgency for short keys, 'normal' for long keys
	local urgency_flag = (#tostring(key) > 3) and "critical" or "normal"

	hl.exec_cmd(
		string.format(
			'notify-send -a "keybind" -u %s -h string:x-canonical-private-synchronous:keybind "  + %s"',
			urgency_flag,
			key
		)
	)
end

-- notify short keybind
local function short_notify(key)
	key = key_symbols[key] or key

	hl.exec_cmd(
		string.format('notify-send -a "keybind" -u "low" -h string:x-canonical-private-synchronous:keybind "%s"', key)
	)
end

-- Reopen closed windows --
---------------------------
local closed_stack = {}
local MAX_STACK = 10

-- Add to stack and close window
local function close_and_push()
	local active_win = hl.get_active_window()

	if active_win and (active_win.initial_class or active_win.class) then
		local class_name = active_win.initial_class
		if not class_name or class_name == "" then
			class_name = active_win.class
		end

		class_name = class_name:lower()

		table.insert(closed_stack, class_name)

		if #closed_stack > MAX_STACK then
			table.remove(closed_stack, 1)
		end
	end

	hl.dispatch((hl.dsp.window.close()))
end

-- Pull from stack and reopen window
local function undo_close()
	if #closed_stack == 0 then
		return
	end
	local reopen = table.remove(closed_stack)

	if reopen then
		hl.dispatch(hl.dsp.exec_cmd(reopen))
	end
end

-- Kill all windows in the active workspace
local function kill_workspace()
	-- Get the active workspace object
	local active_ws = hl.get_active_workspace()
	if not active_ws then
		return
	end

	local active_ws_id = active_ws.id

	-- Fetch all current windows
	local windows = hl.get_windows()
	if not windows then
		return
	end

	-- Loop through and close windows belonging to the active workspace
	for _, win in ipairs(windows) do
		if win.workspace and win.workspace.id == active_ws_id then
			hl.dispatch(hl.dsp.window.close({ window = string.format("address:%s", win.address) }))
		end
	end
end

-- Switch layouts
local function switch_layouts()
	local layouts = { "scrolling", "dwindle" }
	local workspace = hl.get_active_workspace()
	if hl.get_active_special_workspace() then
		workspace = hl.get_active_special_workspace()
	end

	local next_layout = "dwindle"

	if not workspace then
		return
	end

	for i = 1, #layouts do
		if layouts[i] == workspace.tiled_layout then
			local next_layout_idx = (i % #layouts) + 1
			next_layout = layouts[next_layout_idx]
			break
		end
	end

	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
	end
	hl.exec_cmd("hyprctl notify 1 3000 '" .. wal.color1 .. "' 'Switching to '" .. next_layout .. " 'layout'")
end

-- Per Layout Bindings
local function layout_bind(bind_table)
	return function()
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

		if not workspace then
			return
		end

		local layout = workspace.tiled_layout

		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
	end
end

-- Game mode
local function game_mode()
	local mode_status = (hl.get_config("animations.enabled") == false)

	if mode_status then
		hl.exec_cmd("hyprctl reload")
		hl.exec_cmd("hyprctl notify 1 3000 'rgb(40a02b)' 'Gamemode [OFF]'")
		return
	end

	hl.config({
		general = {
			gaps_in = 0,
			gaps_out = 0, -- Disable gaps
			border_size = 0,
		},

		animations = {
			enabled = false, -- Disable animations
		},

		-- Disable blur, shadow, opacity, rounding and window rounding
		decoration = {
			shadow = { enabled = false },
			blur = { enabled = false },
			rounding = 0,
			active_opacity = 1,
			inactive_opacity = 1,
			motion_blur = { enabled = false },
		},
	})
	hl.exec_cmd("hyprctl notify 1 3000 'rgb(40a02b)' 'Gamemode [ON]'")
end

return {
	notify = notify,
	kill_workspace = kill_workspace,
	game_mode = game_mode,
	switch_layouts = switch_layouts,
	layout_bind = layout_bind,
	short_notify = short_notify,
	close_and_push = close_and_push,
	undo_close = undo_close,
}
