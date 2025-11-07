#!/bin/bash

# --- Configuration ---
# NOTE: This script is fragile and depends heavily on the exact text format.
# Upgrade Mako to 1.5+ for the proper JSON output if possible.

# 1. Get the notification history in text format
HISTORY_TEXT=$(makoctl history)

# Check if the history is empty
if [ -z "$HISTORY_TEXT" ]; then
  echo "No notification history." | fuzzel --dmenu -p "History:"
  exit 0
fi

FUZZEL_INPUT=$(echo "$HISTORY_TEXT" | awk '
    /^Notification [0-9]+:/ { 
        # Extract ID and capture the whole line as the Title
        ID = $2; 
        sub(/:$/, "", ID); 
        LINE = $0; 
        sub(/^Notification [0-9]+:/, "", LINE);
        TITLE = LINE;
        current_id = ID;
        next
    }
    /App name:/ {
        # Extract the App Name
        APP = $3;
        # Output the formatted line: ID [App Name] Title
        print current_id " [" APP "]" TITLE
    }
')
# 3. Pipe the formatted list into fuzzel
SELECTED_LINE=$(echo "$FUZZEL_INPUT" | fuzzel --dmenu -p "Notification History: " --index)

# Check if the user selected an item
if [ -n "$SELECTED_LINE" ]; then
  # 4. Extract the notification ID from the selected line
  ID=$(echo "$SELECTED_LINE" | awk '{print $1}')

  # 5. Restore the selected notification using makoctl
  # Use the 'restore' command as this is for dismissed history
  makoctl restore -n "$ID"
fi
