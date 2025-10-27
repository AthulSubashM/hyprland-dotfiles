#!/bin/bash

source "$HOME/.config/hypr/scripts/dmenu/calc_cursor_place.sh"
calc_cursor_place

CONFIG_FILE="$HOME/.config/fuzzel/dmenus/man_pages.ini"

LANG=C apropos . | sort -h |
  fuzzel --dmenu --prompt="󰈙 Man Pages > " --config="$CONFIG_FILE" \
    --anchor="$ANCHOR" \
    --x-margin="$X_MARGIN" \
    --y-margin="$Y_MARGIN" |
  awk '{print $1}' |
  xargs -r -I{} alacritty -T "man {}" -e bash -ic "man {}"
