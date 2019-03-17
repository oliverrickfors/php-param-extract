#!/bin/bash

#1 wwwroot
#2 value/payload

#TODO: add http method to start of line, not only GET

for line in $(find $1 -type f); do

    x=${line#$1}

    for param in $(
    grep -o -P  '\$_(GET|POST|REQUEST|COOKIE|SESSION|SERVER)\[.+\]' $line |
    tr -d "'" #|
    );
    do
    	paramName="$(echo "$param" | grep -oP "\[\K[^]]*")"
    	httpmethod="$(echo "$param" | grep -oP "GET|POST|REQUEST|COOKIE|SESSION|SERVER")"

    	if ! [ -z "$paramName" ] 
    	then
    		echo $httpmethod" "$x"?"$paramName"="$2
    	fi
    done
done
