#!/bin/bash

pkill -x swayosd-server
swayosd-server &
touch ~/.config/waybar/style.css

if [ -f "$1" ]; then
  ln -sf "$1" "$HOME/.config/waypaper/current_wallpaper"
else
  echo "Add wallpaper as agrument"
fi

nm-sidebar --reload-css &
makoctl reload &

pywalfox update &

for socket in /run/user/1000/nvim.*.0; do
  if [ -S "$socket" ]; then
    nvim --server "$socket" --remote-send "<C-\><C-N>:PywalReload<CR>" 2>/dev/null &
  fi
done
