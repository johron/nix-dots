#!/usr/bin/env bash
TARGET="$1"

if nmcli connection show "$TARGET" >/dev/null 2>&1; then
    nmcli connection up "$TARGET"
else
    PASSWORD=$(wofi --dmenu --password --prompt "Wi-Fi Password")
    nmcli device wifi connect "$TARGET" password "$PASSWORD"
fi