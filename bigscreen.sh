#!/bin/sh
xrandr --output eDP1 --primary --mode 1920x1080 --pos 320x1440 --rotate normal --output DP1 --off --output DP2 --off --output HDMI1 --off --output HDMI2 --mode 2560x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off
sleep 1
xrandr --output eDP1 --off --output DP1 --off --output DP2 --off --output HDMI1 --off --output HDMI2 --mode 2560x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off
sleep 1
xrandr --output eDP1 --primary --mode 1920x1080 --pos 320x1440 --rotate normal --output DP1 --off --output DP2 --off --output HDMI1 --off --output HDMI2 --mode 2560x1440 --pos 0x0 --rotate normal --output VIRTUAL1 --off
feh --bg-scale pics/wallpaper\ slideshow/2560x1440/space.jpg
