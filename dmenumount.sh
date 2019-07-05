#!/bin/sh

pgrep -x dmenu && exit

getmount() { \
	[ -z "$chosen" ] && exit 1
	mp="$(find $1 | dmenu -i -p 'Type in mount point.' -nf '#FF0000' -nb '#31004a' -sf '#ffffff' -sb '#ab00ff' -fn 'terminus:pixelsize=12')"
	[ "$mp" = "" ] && exit 1
	if [ ! -d "$mp" ]; then
		mkdiryn=$(printf "No\\nYes" | dmenu -i -p "$mp does not exist. Create it?")
		[ "$mkdiryn" = "Yes" ] && (mkdir -p "$mp" || sudo -A mkdir -p "$mp")
	fi
	}

mountusb() { \
	chosen="$(echo "$usbdrives" | dmenu -i -p 'Mount which drive?' -nf '#FF0000' -nb '#31004a' -sf '#ffffff' -sb '#ab00ff' -fn 'terminus:pixelsize=12' | awk '{print $1}')"
	sudo -A mount "$chosen" && notify-send "$chosen mounted." && exit 0
	getmount "/mnt /home -maxdepth 5 -type d"
	partitiontype="$(lsblk -no "fstype" "$chosen")"
	case "$partitiontype" in
		"vfat") sudo -A mount -t vfat "$chosen" "$mp" -o rw,umask=0000;;
		*) sudo -A mount "$chosen" "$mp"; user="$(whoami)"; ug="$(groups | awk '{print $1}')"; sudo -A chown "$user":"$ug" 741 "$mp";;
	esac
	notify-send "$chosen mounted to $mp."
	}

mountandroid() { \
	chosen=$(echo "$anddrives" | dmenu -i -p 'Which Android device?' -nf '#FF0000' -nb '#31004a' -sf '#ffffff' -sb '#ab00ff' -fn 'terminus:pixelsize=12' | cut -d : -f 1)
	getmount "$HOME -maxdepth 3 -type d"
	simple-mtpfs --device "$chosen" "$mp"
	notify-send "Android device mounted to $mp."
	}

asktype() { \
	case $(printf "USB\\nAndroid" | dmenu -i -p 'Mount a USB drive or Android device?' -nf '#FF0000' -nb '#31004a' -sf '#ffffff' -sb '#ab00ff' -fn 'terminus:pixelsize=12') in
		USB) mountusb ;;
		Android) mountandroid ;;
	esac
	}

anddrives=$(simple-mtpfs -l 2>/dev/null)
usbdrives="$(lsblk -rpo "name,type,size,mountpoint" | grep -v sda | awk '$2=="part"&&$4==""{printf "%s (%s)\n",$1,$3}')"

if [ -z "$usbdrives" ]; then
	[ -z "$anddrives" ] && echo "No USB drive or Android device detected" && exit
	echo "Android device(s) detected."
	mountandroid
else
	if [ -z "$anddrives" ]; then
		echo "USB drive(s) detected."
	       	mountusb
	else
		echo "Mountable USB drive(s) and Android device(s) detected."
		asktype
	fi
fi

