#!/bin/bash

WALLPAPERS_DIR="$HOME/Pictures/Wallpapers/"

ensure_wallpapers_dir() {
    if [ ! -d "$WALLPAPERS_DIR" ]; then
        >&2 echo "Creating a dir for wallpapers at $WALLPAPERS_DIR"
        mkdir -p "$WALLPAPERS_DIR"
    fi
}

swap_wallpaper() {
    if [ ! "$(find "$WALLPAPERS_DIR" -type f)" ]; then
        >&2 echo "$WALLPAPERS_DIR is empty! Add some wallpapers there!"
        exit 1
    fi

    NEW_WALLPAPER="$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)"

    echo "Swaping desktop background image to: file:///$NEW_WALLPAPER"
    gsettings set org.gnome.desktop.background picture-uri-dark "file:///$NEW_WALLPAPER"
    gsettings set org.gnome.desktop.background picture-uri "file:///$NEW_WALLPAPER"
}

download_wallpaper() {
    if [ -z "$TARGET_WALLPAPER" ]; then
        >&2 echo "provide an image url"
        exit 1
    fi

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

while getopts "g:h" opt; do
    case $opt in
        g)
            TARGET_WALLPAPER="$OPTARG"
            download_wallpaper
            exit 0
            ;;
        h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

swap_wallpaper
