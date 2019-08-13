#!/bin/bash

for arg in "$@"
do
	if [ "$arg" == "start" ]
	then
		ip=$(cat /home/philip/scripts/nicetryfbi.txt | grep wan | awk '{print $2}')
		sshuttle --dns -x $ip  -r philip@$ip 0/0 --python=python3 -D
	fi
	if [ "$arg" == "stop" ]
	then
		kill $(pgrep sshuttle) 
		exit 0
	fi
done
