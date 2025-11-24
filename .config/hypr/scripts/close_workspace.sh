#!/bin/bash

# Get active workspace id
active_workspace_id=$(hyprctl activeworkspace -j | jq '.id')

clients_to_close=$(hyprctl clients -j | jq -j --argjson ws_id "$active_workspace_id" \
  '.[] | select(.workspace.id == $ws_id) | "dispatch closewindow address:\(.address);"')

if [ ! -z "$clients_to_close" ]; then
  hyprctl --batch "$clients_to_close"
fi
