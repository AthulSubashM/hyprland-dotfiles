-- ~/.config/hypr/scripts/wal_colors.lua
local M = {}

function M.get_colors()
	local colors = {}
	local path = os.getenv("HOME") .. "/.cache/wal/colors"
	local file = io.open(path, "r")

	if not file then
		-- Fallback if the file doesn't exist yet
		for i = 1, 16 do
			table.insert(colors, "0xffffffff")
		end
		return colors
	end

	for line in file:lines() do
		-- Strip the '#' and prepend '0xff' for Hyprland
		local hex = line:gsub("#", "0xff")
		table.insert(colors, hex)
	end

	file:close()
	return colors
end

return M
