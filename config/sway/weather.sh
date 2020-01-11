#!/usr/bin/env sh
location="$1"

getforecast() { ping -q -c 1 1.1.1.1 > /dev/null 2>&1 || echo ""
curl -s "wttr.in/$location" > "$HOME/.local/share/weatherreport" 2> /dev/null || echo "";}


showweather() { printf "%s" "$(sed '16q;d' "$HOME/.local/share/weatherreport" | grep -wo "[0-9]*%" | sort -n | sed -e '$!d' | sed -e "s/^/☔ /g" | tr -d '\n')"
sed '13q;d' "$HOME/.local/share/weatherreport" | grep -o "m\\(-\\)*[0-9]\\+" | sort -n -t 'm' -k 2n | sed -e 1b -e '$!d' | tr '\n|m' ' ' | awk '{print " ❄️",$1 "°","",$2 "°"}' ;}

case $BLOCK_BUTTON in
    1) $TERMINAL -e less -RS "$HOME/.local/share/weatherreport" ;;
    2) getforecast && showweather ;;
    # need libnotify-bin installed
#    3) pgrep -x dunst >/dev/null && notify-send "🌈 Weather module" "\- Left click for full forecast.
#- Middle click to update forecast.
#☔: Chance of rain/snow
#❄: Daily low
#🌞: Daily high" ;;
esac

if [ "$(stat -c %y "$HOME/.local/share/weatherreport" > /dev/null 2>&1 | awk '{print $1}')" != "$(date '+%Y-%m-%d')" ]
	then getforecast && showweather
	else showweather
fi
