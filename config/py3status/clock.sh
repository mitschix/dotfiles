#!/usr/bin/env sh

date "+ %Y-%m-%d  %H:%M:%S"

if [ $(command -v dunstifyy) ]
    then notifiy="dunstify -r 2" && notifiy2="dunstify -r 3"
    else notifiy="notify-send" && notifiy2="notify-send"
fi

case $BLOCK_BUTTON in
  # need to have libnotify installed
  1) $notifiy -a calendar -i view-app-grid "This Month" "$(cal --color=always -m| sed "s/..7m/<b><span color=\"red\">/;s/..27m/<\/span><\/b>/")" && $notifiy2 -i view-pin -a status "Appointments" "$(calcurse -d3)";;
	2) $TERMINAL -e calcurse ;;
esac
