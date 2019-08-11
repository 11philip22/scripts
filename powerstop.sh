#!/bin/bash

KEYWORDS='(firewire|usb)'

fifo=$(mktemp).$$
mkfifo "${fifo}" || exit 1
nb_positives=$(dmesg | grep -E -i -c "${KEYWORDS}")
nb_positives=$(($nb_positives + 1))

dmesg -w >${fifo} &
grep -E -i -m "${nb_positives}" "${KEYWORDS}" "${fifo}" > /dev/null

sync

sdmem -fll
poweroff -f
