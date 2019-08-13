#!/bin/bash
#written by philip woldhek

serverip=$(cat /home/philip/scripts/nicetryfbi.txt | grep serverip | awk '{print $2}')

wifi="'$(/sbin/iwconfig wlp4s0 | egrep ESSID | cut -d '"' -f 2)'"

if [ "df: no file systems processed" = "$(df -k -F cifs)"]
	then
		if [ $wifi = "'WuTangLAN'" ] && [ "open" = "$(nc -vzw 1 192.168.1.2 445 2>&1 | awk '{print $NF}')" ]
			then
   				mount.cifs //$serverip/raid5 /home/philip/smb/raid -o uid=philip,credentials=/etc/smbcredentials,iocharset=utf8 &
   				mount.cifs //$serverip/4tb /home/philip/smb/4tb -o uid=philip,credentials=/etc/smbcredentials,iocharset=utf8 &
   				mount.cifs //$serverip/3tb /home/philip/smb/3tb -o uid=philip,credentials=/etc/smbcredentials,iocharset=utf8 &
			else
				exit 0
		fi
	else 
		umount /home/philip/smb/raid
		umount /home/philip/smb/3tb
		umount /home/philip/smb/4tb
fi
