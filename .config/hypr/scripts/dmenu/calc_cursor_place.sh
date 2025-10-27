#!/bin/bash
# ----------------------------------------------------
# Function: calculate_fuzzel_placement
# Calculates anchor and margins for fuzzel based on cursor position.
# Exports: ANCHOR, X_MARGIN, Y_MARGIN
# ----------------------------------------------------
calc_cursor_place() {
  # Default values for safety
  local CURSOR_X=0
  local CURSOR_Y=0

  # Get cursor position: Outputs "X Y"
  local CURSOR_POS
  CURSOR_POS=$(hyprctl cursorpos | awk -F', ' '{print $1 " " $2}')

  if [ -z "$CURSOR_POS" ]; then
    # Fallback to center
    export ANCHOR="center"
    export X_MARGIN=0
    export Y_MARGIN=0
  else
    # Parse coordinates
    CURSOR_X=$(echo "$CURSOR_POS" | awk '{print $1}')
    CURSOR_Y=$(echo "$CURSOR_POS" | awk '{print $2}')

    export ANCHOR="top-left"
    export X_MARGIN=$((CURSOR_X - 100))
    export Y_MARGIN=$((CURSOR_Y - 100))
  fi
}
