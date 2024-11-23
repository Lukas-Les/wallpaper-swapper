#!/bin/bash

source "$(dirname "$0")/utils.sh"

if [ ! "$(find "$WALLPAPERS_DIR" -type f)" ]; then
    >&2 echo "$WALLPAPERS_DIR is empty! Add some wallpapers there!"
    exit 1
fi

NEW_WALLPAPER="$(ls "$WALLPAPERS_DIR" | shuf -n 1)"
