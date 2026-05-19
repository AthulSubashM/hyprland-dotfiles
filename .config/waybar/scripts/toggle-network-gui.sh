#!/bin/bash

WINDOW_CLASS="nmtui-float"

# Check if the window is currently open
if hyprctl clients -j | jq -e ".[] | select(.class == \"$WINDOW_CLASS\")" >/dev/null; then
  # If open, kill the window
  hyprctl dispatch "hl.dsp.window.kill({window=\"class:$WINDOW_CLASS\"})"
else
  # If not open, launch the application
  kitty --class nmtui-float -e nmtui
fi
