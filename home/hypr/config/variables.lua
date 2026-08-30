-- Hyprland default apps

TERMINAL     = "kitty"
FILE_MANAGER = "kitty -e yazi"
BROWSER      = "zen"
EDITOR       = "gnome-text-editor --new-window"
CALCULATOR   = "gnome-calculator"

-- Monitors
dofile("/etc/nixos/local/monitors.lua")

-- Workspaces
NUM_WPM = 3 -- Number of workspaces per monitor (Max 10)
