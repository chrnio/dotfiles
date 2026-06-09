#!/usr/bin/env bash
# scripts/wallpaper.sh
# Sets a random wallpaper from ~/Pictures/Wallpapers/ using swaybg.
#
# Called by niri at startup via:
#   spawn-at-startup "bash" "-c" "~/.config/niri/scripts/wallpaper.sh"
#
# Dependencies: swaybg
#   Install: pacman -S swaybg
#
# swaybg is kept running in the background holding the wallpaper surface.
# If you want to change wallpaper without restarting niri, kill swaybg and
# re-run this script.

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Collect all image files from the wallpaper directory.
# `mapfile` reads lines into an array; process substitution avoids a subshell
# so the array is accessible in the current shell.
mapfile -t candidates < <(
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \)
)

if [[ ${#candidates[@]} -eq 0 ]]; then
    echo "wallpaper.sh: no images found in $WALLPAPER_DIR" >&2
    exit 1
fi

# Pick a random entry using $RANDOM (0–32767); modulo gives a valid index.
selected="${candidates[$(( RANDOM % ${#candidates[@]} ))]}"

# Kill any existing swaybg instance before spawning a new one.
# --signal SIGTERM is the default; swaybg cleans up its surface on exit.
pkill swaybg 2>/dev/null

# `exec` replaces this shell process with swaybg so no zombie shell lingers.
# --mode fill: scale the image to fill the output, cropping if needed.
exec swaybg --image "$selected" --mode fill
