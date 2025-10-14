#!/bin/bash

# Get the number of unread notifications
COUNT=$(swaync-client -c)


# Check the count and print the appropriate icon
if [ "$COUNT" -gt 0 ]; then
    echo "$COUNT 󰂚"
else
    echo "󰎟"
fi

exit 0