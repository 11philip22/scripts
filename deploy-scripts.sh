#!/usr/bin/env bash


script_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -s ${script_root}/sshuttle.py /usr/local/bin/vpn
ln -s ${script_root}/autogit.sh /usr/local/bin/autogit

if [[ $1 = "clean" ]]; then
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
        exit
    fi
    rm /usr/local/bin/vpn
    rm /usr/local/bin/autogit
fi