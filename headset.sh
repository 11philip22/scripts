#!/bin/bash

if echo -e "info" | bluetoothctl | grep Missing; then
	echo -e "power on" | bluetoothctl
	sleep 1
	echo -e "connect A0:E6:F8:18:DD:F5" | bluetoothctl
else
	echo -e "power off" | bluetoothctl
fi