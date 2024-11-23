#!/bin/bash

WALLPAPERS_DIR="$HOME/.local/share/wallpapers/"

ensure_wallpapers_dir() {
    if [ ! -d "$WALLPAPERS_DIR" ]; then
        >&2 echo "Creating a dir for wallpapers at $WALLPAPERS_DIR"
        mkdir -p "$WALLPAPERS_DIR"
        >&2 echo "Dir for wallpapers created. Put some wallpapers there!"
        exit 1
    fi
}

swap_wallpaper() {
    if [ ! "$(find "$WALLPAPERS_DIR" -type f)" ]; then
        >&2 echo "$WALLPAPERS_DIR is empty! Add some wallpapers there!"
        exit 1
    fi

    NEW_WALLPAPER="$(ls "$WALLPAPERS_DIR" | shuf -n 1)"
}

download_wallpaper() {
    if [ -z "$TARGET_WALLPAPER" ]; then
        >&2 echo "provide an image url"
        exit 1
    fi

    WALLPAPERS_DIR="$HOME/.local/share/wallpapers/"

    curl -f -o "$WALLPAPERS_DIR$(basename "$TARGET_WALLPAPER")" "$TARGET_WALLPAPER" || {
        >&2 echo "Image download failed for url $TARGET_WALLPAPER"
        exit 1
    }
}

usage() {
    echo "Usage: $0 [-s] [-g <image url>]"
    echo "  -h          Display this help message"
    echo "  -s          Swap wallpaper"
    echo "  -g URL      Get image"
}

ensure_wallpapers_dir

while getopts "sg:h" opt; do
    case $opt in
        s)
            swap_wallpaper
            ;;
        g)
            TARGET_WALLPAPER="$OPTARG"
            download_wallpaper
            ;;
        h)
            usage
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
