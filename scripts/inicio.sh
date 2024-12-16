#!/bin/bash

# Exit immediately if a command exits with a non-zero status
# set -e
(cat /home/nmaximo7/dotfiles/docs/assets/calendar.txt; echo; cat /home/nmaximo7/dotfiles/docs/assets/brain.md; echo; cat /home/nmaximo7/dotfiles/scripts/help.sh) > /home/nmaximo7/dotfiles/docs/main.md
# Initialize swww and set wallpaper
swww init
sleep 1
swww img --transition-type grow /home/nmaximo7/wallpapers/0018.jpg

# Function to launch an application in a specific workspace
launch_app_in_workspace() {
  local workspace="$1"
  local app="$2"

  # Switch to the desired workspace
  hyprctl dispatch workspace "$workspace"
  sleep 0.5  # Wait for the workspace to switch

  # Launch the application
  hyprctl dispatch exec "$app" &
  sleep 0.5  # Wait for the application to launch
}

# Launch applications in respective workspaces
launch_app_in_workspace "1" "alacritty"
launch_app_in_workspace "2" "firefox"
launch_app_in_workspace "3" "md.obsidian.Obsidian"
launch_app_in_workspace "4" "code ~/justtothepoint/"
launch_app_in_workspace "4" "com.google.Chrome"
launch_app_in_workspace "5" "pcmanfm"
launch_app_in_workspace "special:geany" "geany"

