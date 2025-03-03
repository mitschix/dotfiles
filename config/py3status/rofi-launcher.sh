#!/usr/bin/env sh

echo ""

case $BLOCK_BUTTON in
1) rofi -modi drun -show drun -config ~/.config/rofi/rofidmenu.rasi 2>/dev/null ;;
esac
