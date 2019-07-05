#!/bin/bash
#writen by philip woldhek

time=$(date +"%T-%Y-%m-%d")
picturelocation=/home/philip/failedunlock

ffmpeg -f video4linux2 -i /dev/v4l/by-id/usb-Ricoh_Company_Ltd._Integrated_Camera-video-index0 -vframes 3 $picturelocation/$time.jpeg

