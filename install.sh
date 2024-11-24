#!/bin/bash

CRON_SHEDULE="0 * * * *"
APP_LOCATION="$HOME/.local/bin/wallpaper-swap"
cp ./wallpaper-swap.sh "$APP_LOCATION"
chmod +x "$APP_LOCATION"
echo "command moved to $APP_LOCATION"
echo "seting up crotab"
(crontab -l 2>/dev/null; echo "$CRON_SHEDULE $APP_LOCATION") | crontab -
