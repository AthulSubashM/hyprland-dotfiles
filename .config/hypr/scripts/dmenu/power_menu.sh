#!/bin/bash
source "$HOME/.config/hypr/scripts/dmenu/calc_cursor_place.sh"
calc_cursor_place

# OPTIONS="󰐥 Shutdown\n󰜉 Reboot\n󰤄 Hibernate\n󰤁 Suspend\n󰌾 Lock\n󰗽 Logout\n Firmware"
OPTIONS="󰐥 Shutdown\n󰜉 Reboot\n󰤄 Hibernate\n󰤁 Suspend\n󰗽 Firmware\n󰌾 Logout"

# Use fuzzel to display the options and capture the choice
CHOICE=$(
  echo -e "$OPTIONS" | fuzzel \
    --dmenu \
    --prompt "󰍜 Power Menu > " \
    --lines 6 \
    --anchor="$ANCHOR" \
    --x-margin="$X_MARGIN" \
    --y-margin="$Y_MARGIN" \
    --config "$HOME/.config/fuzzel/dmenus/power_menu.ini"
)

# Handle the choice using a case statement
case "$CHOICE" in
"󰐥 Shutdown")
  hyprshutdown -t 'Shutting Down' --post-cmd 'systemctl poweroff'
  ;;
"󰜉 Reboot")
  hyprshutdown -t 'Rebooting' --post-cmd 'systemctl reboot'
  ;;
"󰤄 Hibernate")
  systemctl hibernate
  ;;
"󰤁 Suspend")
  systemctl suspend
  ;;
# "󰌾 Lock")
#   hyprlock
#   ;;
"󰌾 Logout")
  hyprshutdown -t 'Logging out'
  # loginctl terminate-user "$USER"
  ;;
"󰗽 Firmware")
  hyprshutdown -t 'Rebooting to Firmware' --post-cmd 'systemctl reboot --firmware'
  ;;
*)
  exit 0
  ;;
esac
