#!/bin/bash

source "$HOME/.config/hypr/scripts/dmenu/calc_cursor_place.sh"
calc_cursor_place

CONFIG_FILE="$HOME/.config/fuzzel/dmenus/kill_process.ini"

ps -o pid,%cpu,%mem,args -u "$USER" --sort -%mem |
  fuzzel --dmenu --config="$CONFIG_FILE" --prompt="󰛉 Kill Process > " \
    --anchor="$ANCHOR" \
    --x-margin="$X_MARGIN" \
    --y-margin="$Y_MARGIN" |
  awk '{print ${1}' |
  xargs -r kill -9
