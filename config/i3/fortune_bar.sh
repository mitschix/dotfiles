#!/bin/bash
LEN_MAX=90
BLANKS=$( for _ in range{1..200};do echo -n " ";done )

while true; do
    RAND=$((1+$RANDOM % 10))
    if [ $(($RAND % 2)) == 0 ]
    then
        echo "FT - " $(fortune -s -n "$LEN_MAX") "$BLANKS"
    else
        echo "WTC - " $(curl -s http://whatthecommit.com/index.txt) "$BLANKS"
    fi
    sleep 30
done
