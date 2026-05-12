local inc_vol = { "XF86AudioRaiseVolume", Mod .. " + F3" }
local dec_vol = { "XF86AudioLowerVolume", Mod .. " + F2" }
local mute = { "XF86AudioMute", Mod .. " + F1" }

for _, key in ipairs(inc_vol) do
	hl.bind(key, hl.dsp.exec_cmd("swayosd-client --output-volume raise"), {
		repeating = true,
		locked = true,
	})
end

for _, key in ipairs(dec_vol) do
	hl.bind(key, hl.dsp.exec_cmd("swayosd-client --output-volume lower"), {
		repeating = true,
		locked = true,
	})
end

for _, key in ipairs(mute) do
	hl.bind(key, hl.dsp.exec_cmd("swayosd-client --mute-toggle"), {
		repeating = true,
		locked = true,
	})
end

hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
