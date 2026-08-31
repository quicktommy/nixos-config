#!/usr/bin/env bash
set -euo pipefail

USER_NAME="tommy"
HOME_DIR="/home/$USER_NAME"
NIX_HOME="/etc/nixos/home"

echo "Deploying Hyprland..."
mkdir -p "$HOME_DIR/.config"
rm -rf "$HOME_DIR/.config/hypr.new"
cp -a "$NIX_HOME/hypr" "$HOME_DIR/.config/hypr.new"
rm -rf "$HOME_DIR/.config/hypr.old"
if [ -d "$HOME_DIR/.config/hypr" ]; then
    mv "$HOME_DIR/.config/hypr" "$HOME_DIR/.config/hypr.old"
fi
mv "$HOME_DIR/.config/hypr.new" "$HOME_DIR/.config/hypr"
rm -rf "$HOME_DIR/.config/hypr.old"

echo "Deploying Kitty..."
mkdir -p "$HOME_DIR/.config"
rm -rf "$HOME_DIR/.config/kitty.new"
cp -a "$NIX_HOME/kitty" "$HOME_DIR/.config/kitty.new"
rm -rf "$HOME_DIR/.config/kitty.old"
if [ -d "$HOME_DIR/.config/kitty" ]; then
    mv "$HOME_DIR/.config/kitty" "$HOME_DIR/.config/kitty.old"
fi
mv "$HOME_DIR/.config/kitty.new" "$HOME_DIR/.config/kitty"
rm -rf "$HOME_DIR/.config/kitty.old"

echo "Deploying Noctalia..."
mkdir -p "$HOME_DIR/.local/state"
rm -rf "$HOME_DIR/.local/state/noctalia.new"
cp -a "$NIX_HOME/noctalia" "$HOME_DIR/.local/state/noctalia.new"
rm -rf "$HOME_DIR/.local/state/noctalia.old"
if [ -d "$HOME_DIR/.local/state/noctalia" ]; then
    mv "$HOME_DIR/.local/state/noctalia" "$HOME_DIR/.local/state/noctalia.old"
fi
mv "$HOME_DIR/.local/state/noctalia.new" "$HOME_DIR/.local/state/noctalia"
rm -rf "$HOME_DIR/.local/state/noctalia.old"

echo "Deploying wallpapers..."
mkdir -p "$HOME_DIR/Pictures"
rm -rf "$HOME_DIR/Pictures/Wallpapers.new"
cp -a "$NIX_HOME/Wallpapers" "$HOME_DIR/Pictures/Wallpapers.new"
rm -rf "$HOME_DIR/Pictures/Wallpapers.old"
if [ -d "$HOME_DIR/Pictures/Wallpapers" ]; then
    mv "$HOME_DIR/Pictures/Wallpapers" "$HOME_DIR/Pictures/Wallpapers.old"
fi
mv "$HOME_DIR/Pictures/Wallpapers.new" "$HOME_DIR/Pictures/Wallpapers"
rm -rf "$HOME_DIR/Pictures/Wallpapers.old"

echo "Fixing ownership..."
mkdir -p \
    "$HOME_DIR/.config/fish" \
    "$HOME_DIR/.local/share/fish"
chown -R "$USER_NAME:users" \
    "$HOME_DIR/.config/hypr" \
    "$HOME_DIR/.config/kitty" \
    "$HOME_DIR/.config/fish" \
    "$HOME_DIR/.local/share/fish" \
    "$HOME_DIR/.local/state/noctalia" \
    "$HOME_DIR/Pictures/Wallpapers"

echo "Done."
