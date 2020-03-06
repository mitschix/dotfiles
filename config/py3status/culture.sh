#!/bin/sh
setxkbmap -query | awk '$1 == "layout:" {print "[  " $2 " ]"}'

