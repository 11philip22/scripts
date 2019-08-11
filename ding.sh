#!/bin/bash

url=$(cat /home/philip/scripts/nicetryfbi.txt | grep warpnetip | awk '{print $2}')
curl -i -s -k  -X $'POST'  --data-binary $'redirurl=https%3A%2F%2Fwarpnet.nl&zone=warpnet_guest&accept=Akkoord%21' $url
