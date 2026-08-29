#!/usr/bin/env bash
set -euo pipefail

USER_NAME="tommy"
HOME_DIR="/home/$USER_NAME"
NIX_HOME="/etc/nixos/home"

echo "Deploying Hyprland..."
rm -rf "$HOME_DIR/.config/hypr"
mkdir -p "$HOME_DIR/.config"
cp -a "$NIX_HOME/hypr" "$HOME_DIR/.config/hypr"

echo "Deploying Noctalia..."
rm -rf "$HOME_DIR/.local/state/noctalia"
mkdir -p "$HOME_DIR/.local/state"
cp -a "$NIX_HOME/noctalia" "$HOME_DIR/.local/state/noctalia"

echo "Deploying wallpapers..."
rm -rf "$HOME_DIR/Pictures/Wallpapers"
mkdir -p "$HOME_DIR/Pictures"
cp -a "$NIX_HOME/Wallpapers" "$HOME_DIR/Pictures/Wallpapers"

echo "Fixing ownership..."
chown -R "$USER_NAME:users" \
    "$HOME_DIR/.config/hypr" \
    "$HOME_DIR/.local/state/noctalia" \
    "$HOME_DIR/Pictures/Wallpapers"

echo "Done."
