#!/bin/bash
#written by Philip Woldhek

if [ "0000:01:00.0 OFF" = "$(cat /proc/acpi/bbswitch)" ]
 then
   tee /proc/acpi/bbswitch <<<ON
 else
   tee /proc/acpi/bbswitch <<<OFF
fi
