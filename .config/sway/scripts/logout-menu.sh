#!/bin/sh
# Requires: fuzzel, swaylock, swaymsg, systemctl

CHOICE=$(printf "logout\nlock\nreboot\nshutdown\ncancel" | fuzzel --dmenu --prompt="  session: ")

case "$CHOICE" in
	logout)   swaymsg exit ;;
	lock)     swaylock ;;
	reboot)   systemctl reboot ;;
	shutdown) systemctl poweroff ;;
	cancel|"") ;;
esac
