#!/bin/bash

# Get the number of unread notifications
COUNT=$(makoctl history | grep -c '^Notification')

# Check the count and print the appropriate icon
if [ "$COUNT" -gt 0 ]; then
  echo "$COUNT 󰂚"
else
  echo "󰎟"
fi

exit 0

