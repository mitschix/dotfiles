#!/usr/bin/env sh

echo " $(calcurse -t | tail -n +2 | wc -l)"

if [ $(command -v dunstify) ]
    then notifiy="dunstify -r 4"
    else notifiy="notify-send"
fi

case $BLOCK_BUTTON in
  1) $notifiy -i view-list -a status "TODOs" "$(calcurse -t | tail -n +2 )" ;;
	2) $TERMINAL -e calcurse ;;
esac
