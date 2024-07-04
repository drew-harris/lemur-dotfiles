#!/bin/bash

# Debug: Print arguments
echo "Args: $1 $2" >> /tmp/focus_or_launch.log

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <process_name> <window_class>" >> /tmp/focus_or_launch.log
    exit 1
fi

process_name="$1"
window_class="$2"

# Debug: Print process and window class
echo "Process: $process_name, Window Class: $window_class" >> /tmp/focus_or_launch.log

# Function to check if a window of the given class exists
window_exists() {
    xdotool search --class "$1" >/dev/null 2>&1
}

# Check if the window exists, if not, start the application
if ! window_exists "$window_class"; then
    echo "Launching $process_name" >> /tmp/focus_or_launch.log
    $process_name &
    sleep 2  # Give the application more time to start
fi

# Focus on the window
i3-msg "[class=\"$window_class\"] focus"

# Debug: Print focus command
echo "Focused on [class=\"$window_class\"]" >> /tmp/focus_or_launch.log
