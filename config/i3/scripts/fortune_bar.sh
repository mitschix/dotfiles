#!/bin/bash
LEN_MAX=90
while true; do
  RAND=$((1 + RANDOM % 10))
  if [ $((RAND % 2)) == 0 ]; then
    source="FT"
    output=$(fortune -s -n "$LEN_MAX")
  else
    source="WTC"
    # or use local docker file https://github.com/ngerakines/commitment
    # echo "WTC - " $(curl -s http://localhost:<port>/index.txt) "$BLANKS"
    output=$(curl -s https://whatthecommit.com/index.txt)
  fi
  printf "%s - %s%70s\n" "$source" "$output"
  sleep 30
done
