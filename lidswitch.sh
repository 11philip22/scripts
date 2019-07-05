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

read -p "Restart logind? Y/N: " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
 then
    systemctl restart systemd-logind
fi
echo
sed -n 24p /etc/systemd/logind.conf | sed -n 24p /etc/systemd/logind.conf |  awk 'match($0,"="){print substr($0,RSTART+1)}'
