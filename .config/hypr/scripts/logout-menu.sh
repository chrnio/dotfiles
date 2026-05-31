#!/bin/sh
# scripts/logout-menu.sh
# Session action menu via fuzzel dmenu.
# Requires: fuzzel, hyprctl, hyprlock, systemctl

CHOICE=$(printf "logout\nlock\nreboot\nshutdown\ncancel" | fuzzel --dmenu --prompt="  session: ")

case "$CHOICE" in
	logout)
		hyprctl dispatch exit
		;;
	lock)
		hyprlock
		;;
	reboot)
		systemctl reboot
		;;
	shutdown)
		systemctl poweroff
		;;
	cancel|"")
		;;
esac
