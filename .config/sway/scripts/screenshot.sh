#!/bin/sh
# Usage: screenshot.sh [region|fullscreen|copy]
#   region     - select region, open in swappy
#   fullscreen - full screen, open in swappy
#   copy       - select region, copy to clipboard only
# Requires: grim, slurp, swappy, wl-copy

export GTK_THEME=Adwaita:dark

case "${1:-region}" in
region)
	REGION=$(slurp) || exit 0
	grim -g "$REGION" - | swappy -f -
	;;
fullscreen)
	grim - | swappy -f -
	;;
copy)
	REGION=$(slurp) || exit 0
	grim -g "$REGION" - | wl-copy
	;;
*)
	echo "Usage: screenshot.sh [region|fullscreen|copy]" >&2
	exit 1
	;;
esac
