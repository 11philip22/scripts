#!/bin/bash

mount /dev/nvme0n1p7 /mnt/gentoo
sleep 1s
mount -t proc /proc /mnt/gentoo/proc
sleep 1s
mount --rbind /sys /mnt/gentoo/sys
sleep 1s
mount --make-rslave /mnt/gentoo/sys
sleep 1s
mount --rbind /dev /mnt/gentoo/dev
sleep 1s
mount --make-rslave /mnt/gentoo/dev 

chroot /mnt/gentoo /bin/bash 
source /etc/profile 
export PS1="(chroot) $PS1"
