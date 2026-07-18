#!/bin/bash
#
# WORKSPACES_JSON=$(hyprctl workspaces -j)
#
# FUZZEL_INPUT=$(echo "$WORKSPACES_JSON" | jq -r '
#     .[]
#     | select(.id >= 1)
#     | "\(.id) | \(.name)"
#     ' | sort -n)
#
# SELECTED_LINE=$(echo "$FUZZEL_INPUT" | fuzzel \
#   --dmenu --minimal-lines \
#   -p "Select Workspace to Rename: " \
#   -i -a top --y-margin=50)
#
# if [ -z "$SELECTED_LINE" ]; then
#   exit 0
# fi
#
# WORKSPACE_ID=$(echo "$SELECTED_LINE" | awk -F ' | ' '{print $1}' | tr -d ' ')
#
# CURRENT_NAME=$(echo "$SELECTED_LINE" | awk -F ' | ' '{print $2}')
#

WORKSPACE_ID=$(hyprctl activeworkspace -j | jq .id)

NEW_NAME=$(fuzzel \
  --dmenu \
  --prompt-only "Rename workspace $WORKSPACE_ID as " \
  -i -a top --y-margin=50)

if [ -z "$NEW_NAME" ]; then
  exit 0
fi

hyprctl dispatch "hl.dsp.workspace.rename({workspace='$WORKSPACE_ID',name='$NEW_NAME'})"
