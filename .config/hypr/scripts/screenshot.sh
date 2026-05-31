#!/bin/sh
# scripts/screenshot.sh
# Usage: screenshot.sh [region|fullscreen|copy]
#
# region     - select region with slurp, open in swappy
# fullscreen - capture full screen, open in swappy
# copy       - select region with slurp, copy to clipboard only
#
# Requires: grim, slurp, swappy, wl-copy (wl-clipboard)
#
export GTK_THEME=Adwaita:dark

MODE="${1:-region}"

MODE="${1:-region}"

case "$MODE" in
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
