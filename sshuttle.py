#!/usr/bin/env python

import os
import sys
import traceback


if len(sys.argv) < 2:
    print("Usage is vpn-hole start/stop")
    exit(1)

if sys.argv[1] == "start":
    try:
        ip = os.popen("cat /home/philip/scripts/nicetryfbi.txt | \
                     grep wan | awk '{print $2}'").read()
        ip = ip.rstrip()
        os.system("sshuttle --dns -x {0}  -r philip@{0} \
                 0/0 --python=python3 -D".format(ip))
        exit(0)
    except Exception:
        traceback.print_exc()
        print("could not start sshuttle")
        exit(1)

if sys.argv[1] == "stop":
    try:
        os.system("kill $(pgrep sshuttle) > /dev/null 2>&1")
        exit(0)
    except Exception:
        traceback.print_exc()
        print("sshuttle is not running")
        exit(1)
