#!/bin/bash

WINDOW_CLASS="blueman-manager"

# Check if the window is currently open
if hyprctl clients -j | jq -e ".[] | select(.class == \"$WINDOW_CLASS\")" >/dev/null; then
  # If open, kill the window
  hyprctl dispatch "hl.dsp.window.close({window=\"class:$WINDOW_CLASS\"})"
else
  # If not open, launch the application
  blueman-manager
fi
