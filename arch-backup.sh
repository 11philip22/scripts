#!/bin/bash
#written by philip woldhek

now=$(date +"%Y_%m_%d")
uuid=aca1ec3b-a97b-4f32-ba99-4c50b8a98d4f
backuplocation=/mnt/backup
name=arch-backup

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo -e "\e[1m\e[31mRemoving orphans:\e[0m"
pacman -Rscn $(pacman -Qtdq)

echo -e "\e[1m\e[31mEmptying cache:\e[0m"
pacman -Sc

echo -e "\e[1m\e[31mMounting "$backuplocation"...\e[0m"
mount -U $uuid $backuplocation

if [ "/mnt/backup" = "$(cat /proc/mounts | grep /mnt/backup | awk '{print $2}')" ]
then
    echo -e "\e[1m\e[31mBacking up...\e[0m"
    tar -cvpzf $backuplocation/$name-$now.tar.gz --exclude=/backup.tar.gz --exclude=/mnt --one-file-system /
    echo -e "\e[1m\e[31mUnmounting "$backuplocation"...\e[0m"
    umount $backuplocation
    echo -e "\e[1m\e[31mBackup complete!\e[0m"
    exit 0
else
    echo -e "\e[1m\e[31m"$backuplocation" could not be mounted! backup aborted\e[0m"
    exit 1
fi


