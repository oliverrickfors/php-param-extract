#!/bin/bash

#1 wwwroot
#2 target
#3 value

#TODO: add http method to start of line, not only GET

for line in $(find $1 -type f); do
    x=${line#$1}

    for param in $(grep -o -P  '\$_(GET|POST|REQUEST|COOKIE|SESSION|SERVER)\[.+\]' $line | tr -d "'" | grep -Po '\[\K[^]]*'); do
    	echo $httpmethod" "$x"?"$param"="$2
    done
done
