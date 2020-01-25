#!/usr/bin/env sh

date "+ %Y-%m-%d  %H:%M:%S"

case $BLOCK_BUTTON in
  # need to have libnotify installed
  1) pgrep -x dunst >/dev/null && dunstify -r 2 -a calendar -i view-app-grid "This Month" "$(cal --color=always -m| sed "s/..7m/<b><span color=\"red\">/;s/..27m/<\/span><\/b>/")" && dunstify -r 3 -i view-pin -a status "Appointments" "$(calcurse -d3)";;
	2) $TERMINAL -e calcurse ;;
esac
