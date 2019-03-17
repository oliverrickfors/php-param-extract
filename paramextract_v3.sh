#!/bin/bash

#Script to grep through whole web directory and make urls with found $_GET('') to try injections
#Paste output as burp intruder payload

#1 wwwroot
#2 value/payload

for line in $(find $1 -type f); do

    payload=${line#$1}

    for param in $(
    grep -o -P  '\$_(GET)\[.+\]' $line |
    tr -d "'" #|
    );
    do
    	paramName="$(echo "$param" | grep -oP "\[\K[^]]*")"
    	#httpmethod="$(echo "$param" | grep -oP "GET")"
    	httpmethod="GET"

    	if ! [ -z "$paramName" ] 
    	then
    		paramAll=$paramAll$paramName"="$2"&"
    		#echo $httpmethod" "$payload"?"$paramName"="$2
    	fi
    done
    if ! [ -z "$paramAll" ]
	then
    echo $httpmethod" "$payload"?"${paramAll%?}
	fi
    paramAll=""
done
