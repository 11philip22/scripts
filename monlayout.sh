#!/bin/bash
#written by philip woldhek

DMENU=${DMENU:-dmenu}
cmd_list="thuis big solo exit"

function thuis(){
	xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x1080 \
	 --rotate normal --output DP1 --off --output DP2 --off \
	 --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal \
	 --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
}

function bigscreen(){
	xrandr --output eDP1 --primary --mode 1920x1080 --pos 320x1440 \
	--rotate normal --output DP1 --off --output DP2 --off --output HDMI1 \
	--off --output HDMI2 --mode 2560x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off
	sleep 1
	xrandr --output eDP1 --off --output DP1 --off --output DP2 --off --output HDMI1 \
	--off --output HDMI2 --mode 2560x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off
	sleep 1
	xrandr --output eDP1 --primary --mode 1920x1080 --pos 320x1440 \
	--rotate normal --output DP1 --off --output DP2 --off --output HDMI1 \
	--off --output HDMI2 --mode 2560x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off
	feh --bg-scale pics/wallpaper\ slideshow/2560x1440/space.jpg
}

function solo(){
	xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
	--output DP1 --off --output DP2 --off --output HDMI1 --off --output HDMI2 --off --output VIRTUAL1 --off
}

cmd="$(echo $cmd_list | sed 's/ /\n/g' | ${DMENU} -p 'Are you sure?' -nf '#FF0000' -nb '#31004a' -sf '#ffffff' -sb '#ab00ff' -fn 'terminus:pixelsize=12')"

[[ -z $cmd ]] && exit 1

if [[ $cmd = thuis ]]; then
    thuis
elif [[ $cmd = big ]]; then
	bigscreen
elif [[ $cmd = solo ]]; then
	solo
else
    exit 0
fi