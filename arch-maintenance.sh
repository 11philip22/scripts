#!/bin/bash

now=$(date +"%d_%m_%Y")
user=philip

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

rm -rf /home/$user/arch-status-*
mkdir /home/$user/arch-status-$now

echo -e "\e[1m\e[31mRemoving orphans:\e[0m"
pacman -Rscn $(pacman -Qtdq)

echo -e "\e[1m\e[31mEmptying cache:\e[0m"
pacman -Sc

echo -e "\e[1m\e[31mLooking for broken symlinks...\e[0m"
find -xtype l -print > /home/$user/arch-status-$now/broken-symlinks

echo -e "\e[1m\e[31mLooking for failed services...\e[0m"
systemctl --failed > /home/$user/arch-status-$now/systemctl-failed

echo -e "\e[1m\e[31mLooking inside /var/log and systemd journal...\e[0m"
journalctl -p 3 -xb > /home/$user/arch-status-$now/journalctl

echo -e "\e[1m\e[31mSysteminfo is in: /home/"$user"/arch-status-"$now"\e[0m"

chown -R $user /home/$user/arch-status-$now/
