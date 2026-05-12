-- Switch workspaces with Mod + [0-9]
-- Move active window to a workspace with Mod + SHIFT + [0-9]
-- Scilently move active window to a workspace with Mod + CTRL + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(Mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(Mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind(Mod .. " + CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Example special workspace (scratchpad)
hl.bind(Mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(Mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with Mod + scroll
hl.bind(Mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(Mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(Mod .. " + CTRL + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(Mod .. " + CTRL + left", hl.dsp.focus({ workspace = "e-1" }))
