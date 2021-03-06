#!/usr/bin/python3

"""
I created this program to have a simple command to connect
to my home network using sshuttle.
The program has two self explainatory arguments:
start and stop.
"""

import os
import sys
import time


def get_current_ip():  # gets your current ip
    ip = os.popen("curl -s checkip.dyndns.org | \
            sed -e 's/.*Current IP Address: //' -e 's/<.*$//'").read()
    ip = ip.rstrip()
    return ip


def connection_check(ip):  # checks if the connection is successfull
    t_end = time.time() + 60 * 1
    while time.time() < t_end:
        if get_current_ip() == ip:
            print("you are now connected to {0}".format(ip))
            exit(0)
    print("unable to connect")
    exit(1)


def main():
    if len(sys.argv) < 2:  # checks if there are arguments
        print("Usage is vpn-hole start/stop")
        exit(1)

    if sys.argv[1] == "start":
        try:
            ip = os.popen("cat /home/philip/scripts/nicetryfbi.txt | \
                        grep wan | awk '{print $2}'").read()
            ip = ip.rstrip()
            # replace the ip variable with your ip
            if get_current_ip() == ip:  # checks if you are not already connected
                print("you are already connected")
                exit(1)

            os.system("sshuttle --dns -x {0}  -r philip@{0} \
                    0/0 --python=python3 -D".format(ip))  # start a sshuttle vpn

            connection_check(ip)

        except Exception as e:
            print(e)
            print("could not start sshuttle")
            exit(1)

    if sys.argv[1] == "stop":  # finds sshuttle process and kills it
        try:
            os.system("kill $(pgrep sshuttle) > /dev/null 2>&1")
            print("sshuttle killed")
            exit(0)
        except Exception as e:
            print(e)
            print("sshuttle is not running")
            exit(1)


if __name__ == "__main__":
    main()
