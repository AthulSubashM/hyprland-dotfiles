#!/bin/bash
source "$HOME/.config/hypr/scripts/dmenu/calc_cursor_place.sh"
calc_cursor_place

OPTIONS="󰐥 Shutdown\n󰜉 Reboot\n󰤄 Hibernate\n󰤁 Suspend\n󰌾 Lock\n󰗽 Logout"

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
  systemctl poweroff
  ;;
"󰜉 Reboot")
  systemctl reboot
  ;;
"󰤄 Hibernate")
  systemctl hibernate && hyprlock
  ;;
"󰤁 Suspend")
  systemctl suspend && hyprlock
  ;;
"󰌾 Lock")
  hyprlock
  ;;
"󰗽 Logout")
  loginctl terminate-user "$USER"
  ;;
*)
  exit 0
  ;;
esac
