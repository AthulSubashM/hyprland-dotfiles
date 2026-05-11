require("~/.config/hypr/settings/keybinds/mouse.lua")
require("~/.config/hypr/settings/keybinds/workspaces-binds.lua")
require("~/.config/hypr/settings/keybinds/volume-binds.lua")
require("~/.config/hypr/settings/keybinds/screen-binds.lua")

--------------------
--    PROGRAMS    --
--------------------
$terminal = kitty
$terminal2 = alacritty
$fileManager = $terminal -e yazi
$GUIfileManager = thunar
- $menu = wofi --show drun -n
$menu = fuzzel
$browser = firefox
$browser2 = chromium
$taskManager = $terminal2 -T btop -e btop
- $notifications = swaync-client -t -sw
$notifications = makoctl
$editor = $terminal2 -e nvim
$editor2 = antigravity
$mail = $terminal -e aerc
$shell = $editor .bashrc

--------------------------
--    SYSTEM CONTROLS   --
--------------------------
$mod = SUPER - Sets "Windows" key as main modifier

bind = $mod, C, killactive,            
bind = $mod SHIFT, C, forcekillactive,
bind = $mod CTRL, C, exec, ~/.config/hypr/scripts/close_workspace.sh

bind = $mod SHIFT, R, exec, hyprctl reload
bind = ,Caps_Lock, exec, swayosd-client --caps-lock 
bind = ,Num_Lock, exec, swayosd-client --num-lock   

- Zoom in, out & reset
bind = $mod CTRL, mouse_down, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')
bind = $mod CTRL, mouse_up, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')
bind = $mod CTRL, 0, exec, hyprctl -q keyword cursor:zoom_factor 1
binde = $mod CTRL, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')
binde = $mod CTRL, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')

----------------------
--    MENU BINDS    --
----------------------
-See windowrules for notes
bind = $mod , N, exec, env YAZI_CONFIG_HOME=$HOME/.config/yazi/notes alacritty -T "notes" -e yazi "~/Documents/notes"
bind = $mod, M, exec, ~/.config/hypr/scripts/dmenu/man_pages.sh
bind = $mod, X, exec, ~/.config/hypr/scripts/dmenu/kill_process.sh
bind = $mod ALT, M, exec, ~/.config/hypr/scripts/dmenu/arch_wiki_search.sh
bind = $mod, R, exec, ~/.config/hypr/scripts/rename_workspace.sh 



--------------------------
--    WINDOW CONTROLS   --
--------------------------
- Groups
bind = $mod, G, togglegroup
bind = ALT, Tab, changegroupactive, f
bind = Control_L, Tab, changegroupactive, b 

- Mouse: 272:left, 273:right, 274:middle, 275:button4, 276:button5
- Resize windows
bind = $mod, minus, exec, hyprctl dispatch splitratio -0.25
bind = $mod, equal, exec, hyprctl dispatch splitratio +0.25
bind = $mod, mouse:275, exec, hyprctl dispatch splitratio -0.25
bind = $mod, mouse:276, exec, hyprctl dispatch splitratio +0.25

- Move/resize windows with mod + LMB/RMB and dragging
bindm = $mod, mouse:272, movewindow
bindm = $mod, mouse:273, resizewindow
bindm = $mod, mouse:274, movewindow


- Move focus with mod + arrow keys 
bind = $mod, left, movefocus, l    
bind = $mod, right, movefocus, r   
bind = $mod, up, movefocus, u      
bind = $mod, down, movefocus, d    

- Modes
bind = $mod, K, fullscreen,
bind = $mod, F, togglefloating,
bind = $mod ALT, F, pin
- bind = $mod SHIFT, F,  exec, ~/.config/hypr/scripts/mini_player.sh
bind = $mod, P, pseudo, - dwindle
bind = $mod, J, togglesplit, - dwindle
- bind = $mod, TAB, hyprexpo:expo, toggle - Hyprexpo

bind = $mod, O, setprop, active opaque toggle



-----------------------
--    APPLICATIONS   --
-----------------------
bind = $mod, E, exec, $fileManager
bind = $mod ALT, E, exec, $GUIfileManager
bind = $mod, T, exec, $terminal
bind = $mod ALT, T, exec, $terminal2
bind = $mod, space, exec, $menu
bind = $mod, B, exec, $browser
bind = $mod ALT, B, exec, $browser2
bind = $mod, Q, exec, $taskManager 
bind = $mod, A, exec, wofi --show drun --conf=~/.config/wofi/grid.conf
bind = $mod ALT, N, exec, $notifications
bind = $mod ALT, space, exec, ~/.config/hypr/scripts/fzf_search.sh 
bind = $mod, V, exec, $editor
bind = $mod ALT, V, exec, $editor2
bind = $mod CTRL, N, exec, ~/.config/hypr/scripts/dmenu/notifications_history.sh
bind = $mod, D, exec, $notifications dismiss --no-history
bind = $mod CTRL, M, exec, $mail
bind = $mod CTRL, B, exec, $shell

- Screenshot
$ssdir = ~/Pictures/Screenshots/
bind = , PRINT, exec, hyprshot -m output -o $ssdir   - Monitor to file
bind = $mod, PRINT, exec, hyprshot -m window -o $ssdir   - Window to file
bind = $mod SHIFT, PRINT, exec, hyprshot -m region -o $ssdir   - Region to file

bind = Control_L, PRINT, exec, hyprshot -m output --clipboard-only -o $ssdir   - Monitor to clipboard
bind = $mod CTRL, PRINT, exec, hyprshot -m window --clipboard-only -o $ssdir - Window to clipboard
bind = $mod CTRL SHIFT, PRINT, exec, hyprshot -m region --clipboard-only -o $ssdir  - Region clipboard

- Clipboard
bind = $mod SHIFT, V, exec, cliphist list | $menu --dmenu | cliphist decode | wl-copy

---------------------------
--    SWITCHERS & MODES  --
---------------------------
- Wallpaper Switchers
- bind = $mod, W, exec, ~/.config/hypr/scripts/wallpaper_switcher.sh
bind = $mod, W, exec, waypaper --random
bind = $mod ALT, W, exec, waypaper

- Game Mode
bind = $mod, F10, exec, ~/.config/hypr/scripts/game_mode.sh

------------------------                                        
--    POWER OPTIONS   --                                        
------------------------                                        
bind = $mod CTRL SHIFT, X, exec,shutdown now                
bind = $mod SHIFT, H, exec, systemctl hibernate && hyprlock 
bind = $mod, Z, exec, ~/.config/hypr/scripts/dmenu/power_menu.sh                       
bindl = , XF86PowerOff, exec, wlogout                         
bind = $mod, L,exec, hyprlock                               
