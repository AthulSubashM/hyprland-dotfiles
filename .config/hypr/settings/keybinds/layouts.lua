require("settings.themes.animations")
local wal = require("settings.themes.colors")

-- Switch layouts
hl.bind(Mod .. " + period", function()
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
end)

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

hl.bind(
	"SUPER + J",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol r"), -- Scrolling: swap column with left one
		dwindle = hl.dsp.layout("togglesplit"), -- Dwindle: swap window split
	})
)

hl.bind(
	"SUPER + H",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol l"),
		dwindle = hl.dsp.layout("swapsplit"),
	})
)

-- hl.bind(Mod.."+TAB", hl.dsp.window.fullscreen())
-- bind = $mod, TAB, hyprexpo:expo, toggle - Hyprexpo
hl.bind(Mod .. "+TAB", hl.plugin.gloview.toggle)
