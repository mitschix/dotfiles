#!/bin/bash
LEN_MAX=90
BLANKS=$(for _ in range{1..200}; do echo -n " "; done)

while true; do
    RAND=$((1 + $RANDOM % 10))
    if [ $(($RAND % 2)) == 0 ]; then
        echo "FT - " $(fortune -s -n "$LEN_MAX") "$BLANKS"
    else
        # or use local docker file https://github.com/ngerakines/commitment
        # echo "WTC - " $(curl -s http://localhost:<port>/index.txt) "$BLANKS"
        echo "WTC - " $(curl -s https://whatthecommit.com/index.txt) "$BLANKS"
    fi
    sleep 30
done
