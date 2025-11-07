#!/bin/bash
HISTORY_TEXT=$(makoctl history)

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
SELECTED_LINE=$(echo "$FUZZEL_INPUT" | fuzzel --dmenu -p "Notification History: " --index)

if [ -n "$SELECTED_LINE" ]; then
  ID=$(echo "$SELECTED_LINE" | awk '{print $1}')
  makoctl restore -n "$ID"
fi
