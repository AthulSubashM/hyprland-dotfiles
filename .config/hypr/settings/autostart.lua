hl.on("hyprland.start", function()
	hl.exec_cmd("mako")
	hl.exec_cmd("awww & waypaper --restore")
	hl.exec_cmd("hyprpm reload")
	-- hl.exec_cmd("sleep 2 && swayosd-server")
	hl.exec_cmd("sleep 1 && hypridle & systemctl --user start hyprpolkitagent")
	hl.exec_cmd("sleep 2 && wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store")
	hl.exec_cmd("sleep 2 && waybar & wpets-all --watch-config --config ~/.config/bongocat/bongocat.conf")
end)
-- exec-once = waybar
-- -- Wallpapers
-- exec-once = awww
-- exec-once = waypaper --restore
--
--
-- -- System
-- exec-once = sleep 2 && mako
-- exec-once = sleep 2 && swayosd-server
-- exec-once = sleep 2 && hypridle
--
-- exec-once = sleep 2 && systemctl --user start hyprpolkitagent
--
-- exec-once = sleep 2 && wl-paste --type text --watch cliphist store
-- exec-once = sleep 2 && wl-paste --type image --watch cliphist store
--
