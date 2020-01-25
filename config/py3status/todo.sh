#!/usr/bin/env sh

echo " $(calcurse -t | tail -n +2 | wc -l)"

case $BLOCK_BUTTON in
  1) dunstify -r 4 -i view-list -a status "TODOs" "$(calcurse -t | tail -n +2 )" ;;
	2) $TERMINAL -e calcurse ;;
esac
