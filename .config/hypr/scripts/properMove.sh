#!/bin/bash

# Get the current layout and window information
active_window=$(hyprctl activewindow -j)
window_group=$(hyprctl dispatch layout)

# Extract relevant info from the JSON output
orientation=$(echo "$active_window" | jq -r '.orientation')
active_address=$(echo "$active_window" | jq -r '.address')

# If orientation is horizontal, we assume it's up/down. If vertical, left/right
if [[ "$orientation" == "horizontal" ]]; then
    # Swap the windows (togglesplit is already horizontal)
    hyprctl dispatch togglegroup
else
    # Toggle to horizontal split first
    hyprctl dispatch togglesplit
    # Move the active window down
    hyprctl dispatch movewindow d
fi
