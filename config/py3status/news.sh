#!/bin/sh

newsboat -x reload print-unread 2> /dev/null | cut -d " " -f 1 | xargs -I {} echo " {}"

case $BLOCK_BUTTON in
	1) $TERMINAL -e newsboat ;;
esac
