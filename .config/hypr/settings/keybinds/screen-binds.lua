hl.bind("XF86Macro27" or "XF86MonBrightnessUp" or Mod + "F5", hl.dsp.exec_cmd("swayosd-client --brightness raise"), {
	repeating = true,
	locked = true,
})
hl.bind("XF86Macro28" or "XF86MonBrightnessDown" or Mod + "F4", hl.dsp.exec_cmd("swayosd-client --brightness lower"), {
	repeating = true,
	locked = true,
})
