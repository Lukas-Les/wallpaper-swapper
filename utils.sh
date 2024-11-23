WALLPAPERS_DIR="$HOME/.local/share/wallpapers/"

ensure_wallpapers_dir() {
    if [ ! -d "$WALLPAPERS_DIR" ]; then
        >&2 echo "Creating a dir for wallpapers at $WALLPAPERS_DIR"
        mkdir -p "$WALLPAPERS_DIR"
        >&2 echo "Dir for wallpapers created. Put some wallpapers there!"
        exit 1
    fi
}
