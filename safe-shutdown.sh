#!/bin/bash

if pgrep -il "vmware-vmx" &>/dev/null; then
    notify-send "vm is running!"
else
    docker stop $(docker ps -aq)
    shutdown
fi
