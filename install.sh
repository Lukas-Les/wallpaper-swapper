#!/bin/bash

CRON_SHEDULE="0 * * * *"
APP_LOCATION="$HOME/.local/bin/wallpaper-swap"

CRON_JOB="$CRON_SHEDULE $APP_LOCATION"
BOOT_CRON_JOB="@reboot $APP_LOCATION"
CURRENT_CRONTAB=$(crontab -l 2>/dev/null)

cp ./wallpaper-swap.sh "$APP_LOCATION"
chmod +x "$APP_LOCATION"
echo "command moved to $APP_LOCATION"

if ! echo "$CURRENT_CRONTAB" | grep -qF "$CRON_JOB"; then
    echo "seting up crotab"
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
fi

if ! echo "$CURRENT_CRONTAB" | grep -qF "$BOOT_CRON_JOB"; then
    echo "seting up boot crotab"
    (crontab -l 2>/dev/null; echo "$BOOT_CRON_JOB") | crontab -
fi
