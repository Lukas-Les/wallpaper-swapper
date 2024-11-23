#!/bin/bash

source "$(dirname "$0")/utils.sh"

if [ -z "$1" ]; then
    >&2 echo "provide an image url"
    exit 1
fi

TARGET_WALLPAPER=${1}
WALLPAPERS_DIR="$HOME/.local/share/wallpapers/"

curl -f -o "$WALLPAPERS_DIR$(basename "$TARGET_WALLPAPER")" "$TARGET_WALLPAPER" || {
    >&2 echo "Image download failed for url $TARGET_WALLPAPER"
    exit 1
}
