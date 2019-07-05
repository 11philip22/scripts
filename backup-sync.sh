#!/bin/bash
#written by Philip Woldhek

while inotifywait -r /home/philip/school/*; do
    rsync -avu --delete /home/philip/school/ /mnt/backup/school-backup
done &

while inotifywait -r /home/philip/pictures/*; do
    rsync -avu --delete /home/philip/pictures/ /mnt/backup/pictures-backup
done &

while inotifywait -r /home/philip/scripts/*; do
    rsync -avu --delete /home/philip/scripts/ /mnt/backup/scripts-backup
done &

while inotifywait -r /home/philip/videos/*; do
    rsync -avu --delete /home/philip/videos/ /mnt/backup/videos-backup
done
