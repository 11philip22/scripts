#!/bin/bash
#written by philip woldhek

while [ "closed" = "$(cat /proc/acpi/button/lid/LID/state | awk '{print $NF}')" ]
 do
   i3lock
 done
