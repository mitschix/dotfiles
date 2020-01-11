#!/bin/bash
LEN_MAX=90
BLANKS=$( for _ in range{1..200};do echo -n " ";done )

while true; do
  echo $(fortune -s -n "$LEN_MAX") "$BLANKS"
	sleep 30
done
