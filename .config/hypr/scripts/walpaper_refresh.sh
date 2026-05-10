#!/bin/bash

# Check if waybar is running
if pgrep -x "waybar" >/dev/null; then
  # If running, kill the waybar process
  pkill -x "waybar"
fi
waybar &

makoctl reload

if pgrep -x "swayosd-server" >/dev/null; then
  pkill swayosd-server
fi
swayosd-server &
