#!/bin/bash
if [[ "muted" = "$(pamixer --get-volume-human)" ]]; then
	echo "M:"
else
	echo "VOL:"
fi