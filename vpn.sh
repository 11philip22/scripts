#!/bin/bash
# writen by Philip Woldhek

pid=$(ps cax | grep sshuttle | awk '{print $1;}')

if [ "sshuttle"  =  "$(ps cax | grep sshuttle | awk '{print $NF}')" ]
 then
   kill -SIGTERM $pid
 else
   sshuttle --dns -r name@ip 0/0
fi
