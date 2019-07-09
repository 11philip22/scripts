#!/usr/bin/env python

import os
import sys
import traceback
import time


def get_current_ip():
    ip = os.popen("curl -s checkip.dyndns.org | \
            sed -e 's/.*Current IP Address: //' -e 's/<.*$//'").read()
    ip = ip.rstrip()
    return ip


def connection_check(ip):
    t_end = time.time() + 60 * 1
    while time.time() < t_end:
        if get_current_ip() == ip:
            print("you are now connected to {0}".format(ip))
            exit(0)
    print("unable to connect")
    exit(1)


if len(sys.argv) < 2:
    print("Usage is vpn-hole start/stop")
    exit(1)

if sys.argv[1] == "start":
    try:
        ip = os.popen("cat /home/philip/scripts/nicetryfbi.txt | \
                    grep wan | awk '{print $2}'").read()
        ip = ip.rstrip()

        if get_current_ip() == ip:
            print("you are already connected")
            exit(1)

        os.system("sshuttle --dns -x {0}  -r philip@{0} \
                0/0 --python=python3 -D".format(ip))

        connection_check(ip)

    except Exception:
        traceback.print_exc()
        print("could not start sshuttle")
        exit(1)

if sys.argv[1] == "stop":
    try:
        os.system("kill $(pgrep sshuttle) > /dev/null 2>&1")
        print("sshuttle killed")
        exit(0)
    except Exception:
        traceback.print_exc()
        print("sshuttle is not running")
        exit(1)
