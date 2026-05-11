-- bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+     
-- bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-   

hl.bind("XF86Macro27", hl.dsp.exec_cmd("swayosd-client --brightness raise"), {
  repeating = true, locked = true
})
hl.bind("XF86Macro28", hl.dsp.exec_cmd("swayosd-client --brightness lower"), {
  repeating = true, locked = true
})
bindel = ,XF86MonBrightnessUp, exec, swayosd-client --brightness raise   
bindel = ,XF86MonBrightnessDown, exec, swayosd-client --brightness lower 

bindel = $mainMod, F4, exec,  swayosd-client --brightness lower 
bindel = $mainMod, F5, exec,  swayosd-client --brightness raise 
