#!/bin/bash
#written by Philip Woldhek

if [ "HandleLidSwitch=ignore" = "$(sed -n 24p /etc/systemd/logind.conf)" ]
 then
   sed -i '24s/.*/HandleLidSwitch=suspend/' /etc/systemd/logind.conf
   sed -i '25s/.*/HandleLidSwitchExternalPower=suspend/' /etc/systemd/logind.conf
 else
   sed -i '24s/.*/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
   sed -i '25s/.*/HandleLidSwitchExternalPower=ignore/' /etc/systemd/logind.conf
fi

sed -n 24p /etc/systemd/logind.conf | sed -n 24p /etc/systemd/logind.conf |  awk 'match($0,"="){print substr($0,RSTART+1)}'
echo -e "\e[1m\e[31mrestart systemd-logind manually\e[0m"
