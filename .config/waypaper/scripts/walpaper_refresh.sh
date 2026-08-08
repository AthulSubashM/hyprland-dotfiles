#!/bin/bash

pkill -x swayosd-server
swayosd-server &
touch ~/.config/waybar/style.css

nm-sidebar --reload-css &
makoctl reload &

pywalfox update &

for socket in /run/user/1000/nvim.*.0; do
  if [ -S "$socket" ]; then
    nvim --server "$socket" --remote-send "<C-\><C-N>:PywalReload<CR>" 2>/dev/null &
  fi
done
